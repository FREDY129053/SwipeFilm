import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_film/features/waiting_room/AnimationStar.dart';
import 'package:swipe_film/features/waiting_room/animation_room.dart';
import '../../mysql.dart';

class StarWhileWaiting {
  final int roomID;

  StarWhileWaiting(this.roomID);

  final rotateStar = AnimationStar();
  final staticStar = Transform.rotate(angle: -45,
          child: Transform.scale(
            scale: 1.2,
            child: SvgPicture.asset(
                'assets/svg/little_star.svg'),
          )
      );

  Stream<List<Widget>> getStar() async* {
    while (true){
      List<Widget> tmp = [];
      int active = await _allCount(roomID);
      int inRoom = await _inRoomCount(roomID);
      int isStart = await _isStartRoom(roomID);
      tmp.add(
        Text("$inRoom/$active вошли в комнату",
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            color:  Color.fromRGBO(135, 59, 49, 1),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        )
      );

      tmp.add(SizedBox(height: 40),);
      tmp.add(Text(isStart.toString()),);

      for (int i = 0; i < inRoom; i++) {
        tmp.add(rotateStar);
      }

      for (int i = 0; i < active - inRoom; i++) {
        tmp.add(staticStar);
      }
      await Future.delayed(Duration(seconds: 1));
      yield tmp;
    }
  }


  Future<int> _allCount(int id) async {
    int tmp = 0;
    var conn = await mysql().connect();
    await Future.delayed(Duration(microseconds: 1000000));
    var result = await conn.query('SELECT count_of_people FROM rooms WHERE id = ?', [id]);
    tmp = result.first['count_of_people'];
    conn.close();

    return tmp;
  }

  Future<int> _inRoomCount(int id) async {
    int tmp = 0;
    var conn = await mysql().connect();
    await Future.delayed(Duration(microseconds: 1000000));
    var result = await conn.query('SELECT COUNT(*) AS people FROM particians_of_rooms WHERE room_id = ?', [id]);
    tmp = result.first['people'];
    conn.close();

    return tmp;
  }
  Future<int> _isStartRoom(int id) async {
    int tmp = 0;
    var conn = await mysql().connect();
    await Future.delayed(Duration(microseconds: 1000000));
    var result = await conn.query('SELECT is_start FROM rooms WHERE id = ?', [id]);
    tmp = result.first['is_start'];
    conn.close();

    return tmp;
  }
}