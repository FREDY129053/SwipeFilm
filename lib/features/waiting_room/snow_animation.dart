import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Snow extends StatefulWidget {
  const Snow({Key? key}) : super(key: key);

  @override
  State<Snow> createState() => _SnowState();
}

class _SnowState extends State<Snow> {
  List<SnowModel> listSnow = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      var data = SnowModel(
        size: (Random().nextInt(16) + 4).toDouble(),
        top: -10,
        left: Random().nextDouble() * MediaQuery.of(context).size.width * 0.95,
        duration: Random().nextInt(8) + 4,
      );
      setState(() {
        listSnow.add(data);
      });
      Future.delayed(Duration(milliseconds: 50), () {
        setState(() {
          listSnow.last.top = MediaQuery.of(context).size.height;
        });
      });
      if (timer.tick > 10) {
        var max = 4;
        var min = listSnow.length - 5;
        var randomIndex = Random().nextInt(max) + min;

        listSnow[randomIndex].left = listSnow[randomIndex].left! +
            (listSnow[randomIndex].left! >
                MediaQuery.of(context).size.width * 0.5
                ? -50.0
                : 50.0);
      }
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Когда анимация начинается и кончается в датах
    DateTime currData = DateTime.now();
    DateTime start = DateTime(DateTime.now().year, 12, 20);
    DateTime stop = DateTime(DateTime.now().year + 1, 1, 20);

    if (currData.isAfter(start) && currData.isBefore(stop)) {
        return Stack(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.transparent,
            ),
            Stack(
              children: listSnow.map((element) {
                return AnimatedPositioned(
                  top: element.top,
                  left: element.left,
                  duration: Duration(seconds: element.duration!),
                  curve: Curves.linear,
                  child: Image.asset(
                    'assets/images/snowflake.png',
                    // Укажите путь к вашему изображению снежинки
                    width: element.size,
                    height: element.size,
                  ),
                );
              }).toList(),
            )
          ],
        );
    } else {
      return const Stack();
    }
  }
}

class SnowModel {
  double? size;
  double? top;
  double? left;
  int? duration;

  SnowModel({this.size, this.top, this.left, this.duration});

  SnowModel.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    top = json['top'];
    left = json['left'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['top'] = this.top;
    data['left'] = this.left;
    data['duration'] = this.duration;
    return data;
  }
}
