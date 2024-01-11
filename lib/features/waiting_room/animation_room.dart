import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../mysql.dart';
import '../../on_changes/card_provider.dart';
import '../../repo/models/FilmInfo.dart';
import 'AnimationStar.dart';
import 'dynamic_stars.dart';

class AnimationRoom extends StatefulWidget {
  const AnimationRoom({super.key});

  @override
  _AnimationRoomState createState() => _AnimationRoomState();
}

class _AnimationRoomState extends State<AnimationRoom> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    // final args = ModalRoute.of(context)!.settings.arguments as List;
    // final int roomID = args[0];
    // final provider = Provider.of<CardProvider>(context, listen: false);
    // _testResult = provider.test(roomID, 0);
  }

  // Future<Future<bool>> _initializeTestResult() async {
  //   final args = ModalRoute.of(context)!.settings.arguments as List;
  //   final int roomID = args[0];
  //   final provider = Provider.of<CardProvider>(context, listen: false);
  //   // return provider.test(roomID, 0);
  //   // _testResult = test(roomID, theme);
  //   // setState(() {});
  // }


  @override
  Widget build(BuildContext context) {
    // Запрет переворота экрана в горизонтальный режим
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final provider = Provider.of<CardProvider>(context, listen: false);

    final args = ModalRoute.of(context)!.settings.arguments as List;
    final int roomID = args[0];
    final String pass = args[1];
    final bool isAdmin = args[2];

    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);

    final stars = StarWhileWaiting(roomID);
    final rotateStar = AnimationStar();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F0E1),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              // Звезда сверху
              Transform.translate(
                offset: Offset(
                    deviceWidth(context) * 0.03, deviceHeight(context) * -0.29),
                child: Transform.scale(
                  scale: 1.2,
                  child: SvgPicture.asset('assets/svg/mainmenu_star1.svg'),
                ),
              ),
              // текст на звезде
              Container(
                padding: const EdgeInsets.only(top: 80),
                child: Text('Ждем\nлюдей...',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: mainTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Transform.translate(
                offset: const Offset(200, 700),
                child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
              ),

              // колонка с текстовыми полями
              Container(
                  width: 350,
                  padding: const EdgeInsets.only(top: 300),
                  child: Column(
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ID комнаты: ',
                              style: GoogleFonts.raleway(
                                color: mainTextColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            // Копирование текста в буфер обмена
                            GestureDetector(
                              onTap: () {
                                final String text = "ID: ${roomID.toString()}\nПароль: $pass";
                                Clipboard.setData(ClipboardData(text: text));
                              },
                              child: Text(
                                roomID.toString(),
                                style: GoogleFonts.raleway(
                                  color: mainTextColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 80),
                      // ряд звезд
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Expanded (
                              child:  StreamBuilder<List<Widget>>(
                              stream: stars.getStar(),
                              builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return rotateStar;
                                } else if (snapshot.hasError){
                                  return Text("Error stars! ${snapshot.error}");
                                } else if (!snapshot.hasData) {
                                  return const Text("No data!");
                                } else {
                                  final widgets = snapshot.data!.sublist(3);
                                  final text = snapshot.data![0];
                                  final padd = snapshot.data![1];
                                  final isStartText = snapshot.data![2];
                                  // Проверяет значение isStart для изменения всех экранов
                                  if (isStartText is Text && isStartText.data?[0] == '1') {
                                    provider.test(roomID).then((result) {
                                      print("TMP = ${result.length} and ${result.runtimeType}");
                                      Future.delayed(const Duration(milliseconds: 1000), () {
                                        Navigator.pushNamedAndRemoveUntil(context, '/film_card', arguments: [roomID, int.parse(isStartText.data![1]), result], (route) => false);
                                      });
                                    });
                                    // Future.delayed(const Duration(milliseconds: 1000), () {
                                    //   Navigator.pushNamedAndRemoveUntil(context, '/film_card', arguments: [roomID, int.parse(isStartText.data![1])], (route) => false);
                                    // });
                                  }

                                  return Column(
                                    children: [
                                          Row (
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: widgets
                                      ),
                                          padd,
                                          text,
                                    ],
                                  );
                                }
                              },
                            )
                          ),
                        ]
                      ),


                      const SizedBox(height: 30),

                      // кнопка входа
                      Visibility(
                        visible: isAdmin,
                        child: Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: const Color.fromRGBO(184, 9, 72, 0.25),
                                backgroundColor: const Color.fromRGBO(255, 173, 15, 1),
                                minimumSize: const Size(275, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () async {
                                var conn = await mysql().connect();
                                await Future.delayed(Duration(microseconds: 1000000));
                                await conn.query('UPDATE rooms SET is_start = ? WHERE id = ?;', [1, roomID]);
                              },
                              child: Text('ВЛЕТЕТЬ!',
                                style: GoogleFonts.raleway
                                  (fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            )
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),

          // звезда снизу
          // Expanded(
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: FractionallySizedBox(
          //       alignment: Alignment.bottomRight,
          //       widthFactor: 0.3,
          //       // регулируйте это значение для смещения изображения вправо
          //       heightFactor: 0.55,
          //       child: OverflowBox(
          //         maxWidth: double.infinity,
          //         maxHeight: double.infinity,
          //         child: Transform.scale(
          //           scale: 0.8,
          //           // регулируйте это значение для уменьшения масштаба звезды
          //           child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
 //   @override
 //   Widget build(BuildContext context) {
 //     // Запрет переворота экрана в горизонтальный режим
 //     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
 //
 //     return Scaffold(
 //       body: Column(
 //         mainAxisAlignment: MainAxisAlignment.center,
 //         children: [
 //           Center(
 //             child: RotationTransition(
 //               turns: _animation,
 //               child: Transform.scale(
 //                 scale: 1.2,
 //                 child: SvgPicture.asset('assets/svg/maskot.svg'),
 //               ),
 //             ),
 //           )
 //         ],
 //       ),
 //     );
 //   }
 // }


