import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class EnterRoom extends StatefulWidget {
  const EnterRoom({Key? key}) : super(key: key);

  @override
  _EnterRoomState createState() => _EnterRoomState();
}

class _EnterRoomState extends State<EnterRoom>
{
  @override
  Widget build(BuildContext context) {
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F0E1),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Transform.translate(
                    offset: Offset(0, -220),
                    child: Container(
                      width: 423,
                      child: SvgPicture.asset('assets/svg/mainmenu_star1.svg'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: Text('Войти в\nкомнату',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        color:  mainTextColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(200, 700),
                    child: Container(
                      child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                    ),
                  ),

                  Container(
                      width: 350,
                      padding: EdgeInsets.only(top: 300),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text('ID',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 23,
                                  color: mainTextColor,
                                  ),
                            ),
                          ),
                          Material(
                            elevation: 20,
                            shadowColor: Color.fromRGBO(184, 9, 72, 0.15),
                            borderRadius: BorderRadius.circular(25),
                            child: TextField(
                              obscureText: true,
                              obscuringCharacter: "*",
                              style: const TextStyle(
                                  color: Color.fromRGBO(186, 151, 161, 1)),
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.remove_red_eye),
                                  suffixIconColor: Color.fromRGBO(186, 151, 161, 1),
                                  fillColor: Color.fromRGBO(255, 248, 246, 1),
                                  filled: true,
                                  hintText: 'Введите ID комнаты',
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(186, 151, 161, 1)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  )
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text('Пароль',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 23,
                                  color: mainTextColor,
                                  ),
                            ),
                          ),
                          Material(
                            elevation: 20,
                            shadowColor: Color.fromRGBO(184, 9, 72, 0.15),
                            borderRadius: BorderRadius.circular(25),
                            child: TextField(
                              obscureText: true,
                              obscuringCharacter: "*",
                              style: const TextStyle(
                                  color: Color.fromRGBO(186, 151, 161, 1)),
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.remove_red_eye),
                                  suffixIconColor: Color.fromRGBO(186, 151, 161, 1),
                                  fillColor: Color.fromRGBO(255, 248, 246, 1),
                                  filled: true,
                                  hintText: 'Введите пароль от комнаты',
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(186, 151, 161, 1)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  )
                              ),
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(top: 60),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Color.fromRGBO(184, 9, 72, 0.25),
                                  elevation: 10,
                                  backgroundColor: Color.fromRGBO(255, 173, 15, 1),
                                  minimumSize: Size(275, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/main');
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


              // Expanded(
              //     child: Transform.translate(
              //         offset: Offset(200, 50),
              //       child: Container(
              //         child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
              //       ),
              //     ),
              // ),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: FractionallySizedBox(
              //       alignment: Alignment.bottomRight,
              //       widthFactor: 0.3, // регулируйте это значение для смещения изображения вправо
              //       heightFactor: 0.8,
              //       child: OverflowBox(
              //         maxWidth: double.infinity,
              //         maxHeight: double.infinity,
              //         child: Transform.scale(
              //           scale: 0.8, // регулируйте это значение для уменьшения масштаба звезды
              //           child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),

          //верхняя часть со звездой и текстом
          // Transform.translate(
          //   offset: Offset(0, -220), // для того, чтобы звезда находилась наверху и была обрезана рамками экрана
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       //звезда
          //       Container(
          //         child: SvgPicture.asset('assets/svg/mainmenu_star1.svg'),
          //       ),
          //
          //       //текст на звезде
          //       Transform.translate(
          //         offset: Offset(0, 70), // Adjust the value as necessary
          //         child: Text(
          //           "Войти в\nкомнату",
          //           textAlign: TextAlign.center,
          //           style: GoogleFonts.raleway(
          //             color: Color(0xFF873B31),
          //             fontSize: 32,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          //колонна из двух кнопок

          // Container(
          //   width: 350,
          //   padding: EdgeInsets.only(top: 30),
          //   child: Column(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(10),
          //         alignment: Alignment.topLeft,
          //         child: Text('ID',
          //         textAlign: TextAlign.center,
          //         style: GoogleFonts.raleway
          //           (fontWeight: FontWeight.w700,
          //             fontSize: 23,
          //             color: Color(0xFF873B31),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          //декоративная звезда снизу

        ],
      ),
    );
  }
}
