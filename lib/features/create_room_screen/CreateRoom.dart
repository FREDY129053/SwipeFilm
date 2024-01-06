import 'dart:async';

import 'package:mysql1/mysql1.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class DBCreateRoom
{
  Future<int> RoomCommit(int hostId, int numberOfPeople, int roomType, String password, MySqlConnection conn)
  async {
    var bytes = utf8.encode(password);
    await Future.delayed(Duration(microseconds: 1000000));
    await conn.query('INSERT rooms (code, count_of_people, theme, host_id) VALUES (?, ?, ?, ?);', [sha1.convert(bytes).toString(), numberOfPeople, roomType, hostId]);
    await Future.delayed(Duration(microseconds: 1000000));
    var roomId = await conn.query('SELECT id FROM rooms WHERE host_id = ?', [hostId]);
    int endRoomId = roomId.toString().length - 2;
    int roomIdInt = int.parse(roomId.toString().substring(14, endRoomId));
    return roomIdInt;
  }
}
