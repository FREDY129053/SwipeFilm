import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_film/features/waiting_room/waiting_room.dart';
import 'package:swipe_film/mysql.dart';

import 'package:swipe_film/features/enter_room_screen/EnterRoom.dart';


class WaitingRoom extends StatefulWidget {
  const WaitingRoom({Key? key}) : super(key: key);

  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom>
{
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = "";



  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
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
                offset: Offset(deviceWidth(context)*0.03, deviceHeight(context)*-0.29),
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
                    color:  mainTextColor,
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
                          color:  mainTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 80),
                      // ряд звезд
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform.rotate(angle: -45,
                              child: Transform.scale(
                                scale: 1.2,
                                child: SvgPicture.asset('assets/svg/little_star.svg'),
                              )
                          ),
                          Transform.rotate(angle: -45,
                              child: Transform.scale(
                                scale: 1.2,
                                child: SvgPicture.asset('assets/svg/little_star.svg'),
                              )
                          ),
                        ],
                      ),

                      SizedBox(height: 40),

                      Text("1/2 вошли в комнату",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          color:  mainTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 40),

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
                              var conn = await mysql().connect();
                              String result = await DBEnterRoom().EnterRoom(id.text, password.text, conn);
                              if (result == "")
                              {
                                Navigator.of(context).pushNamed('/animation_room');
                              }
                              else
                              {
                                error = result;
                                print(error);
                              }
                              await Future.delayed(Duration(microseconds: 1000000));
                              conn.close();
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
                widthFactor: 0.3, // регулируйте это значение для смещения изображения вправо
                heightFactor: 0.55,
                child: OverflowBox(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: Transform.scale(
                    scale: 0.8, // регулируйте это значение для уменьшения масштаба звезды
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
