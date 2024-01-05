import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_film/features/waiting_room/snow_animation.dart';

import '../../on_changes/card_provider.dart';
import 'AnimationStar.dart';
import 'dynamic_stars.dart';

class AnimationRoom extends StatefulWidget {
  @override
  _AnimationRoomState createState() => _AnimationRoomState();
}

class _AnimationRoomState extends State<AnimationRoom> with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    // Запрет переворота экрана в горизонтальный режим
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);

    final stars = StarWhileWaiting();
    final rotateStar = AnimationStar();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F0E1),
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
                padding: EdgeInsets.only(top: 80),
                child: Text('Ждем\nлюдей...',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: mainTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // Transform.translate(
              //   offset: Offset(200, 700),
              //   child: Container(
              //     child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
              //   ),
              // ),

              // колонка с текстовыми полями
              Container(
                  width: 350,
                  padding: EdgeInsets.only(top: 300),
                  child: Column(
                    children: [
                      // айди комнаты
                      Text('ID комнаты: 115111',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          color: mainTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 80),
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
                                  return Text("Error! ${snapshot.error}");
                                } else if (!snapshot.hasData) {
                                  return Text("No data!");
                                } else {
                                  final widgets = snapshot.data!.sublist(1);
                                  final text = snapshot.data![0];
                                  final padd = snapshot.data![1];
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


                      SizedBox(height: 30),

                      // кнопка входа
                      Container(
                          margin: EdgeInsets.only(top: 50),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: Color.fromRGBO(184, 9, 72, 0.25),
                              backgroundColor: Color.fromRGBO(255, 173, 15, 1),
                              minimumSize: Size(275, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () async {
                              final provider = Provider.of<CardProvider>(context, listen: false);
                              if (await provider.test()) {
                                Future.delayed(const Duration(milliseconds: 500), () {
                                Navigator.pushNamedAndRemoveUntil(context, '/film_card', (route) => false);
                              });
                              }
                            },
                            child: Text('ВЛЕТЕТЬ!',
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.white),
                            ),
                          )
                      ),

                    ],
                  )
              ),
            ],
          ),

          // звезда снизу
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: FractionallySizedBox(
                alignment: Alignment.bottomRight,
                widthFactor: 0.3,
                // регулируйте это значение для смещения изображения вправо
                heightFactor: 0.55,
                child: OverflowBox(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: Transform.scale(
                    scale: 0.8,
                    // регулируйте это значение для уменьшения масштаба звезды
                    child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                  ),
                ),
              ),
            ),
          ),
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


