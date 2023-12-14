import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_film/features/enter_room_screen/EnterRoom.dart';
import 'package:swipe_film/mysql.dart';


class EnterRoom extends StatefulWidget {
  const EnterRoom({Key? key}) : super(key: key);

  @override
  _EnterRoomState createState() => _EnterRoomState();
}

class _EnterRoomState extends State<EnterRoom>
{
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = "";

  bool _obsecureText = true;
  bool _obsecureText_2 = true;

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
                    child: Text('Войти в\nкомнату',
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
                          // текст ID
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
                          // виджет для тени
                          Material(
                            elevation: 20,
                            shadowColor: Color.fromRGBO(184, 9, 72, 0.15),
                            borderRadius: BorderRadius.circular(25),
                            // поле для заполнения
                            child: TextField(
                              controller: id,
                              obscureText: _obsecureText,

                              style: const TextStyle(
                                  color: Color.fromRGBO(186, 151, 161, 1)),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: (){
                                      setState(() {
                                        _obsecureText =! _obsecureText;
                                      });
                                    }, icon: Icon(_obsecureText? Icons.visibility: Icons.visibility_off),
                                  ),
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

                          // отступ между полями
                          const SizedBox(
                            height: 20,
                          ),

                          // текст
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

                          // тень
                          Material(
                            elevation: 20,
                            shadowColor: Color.fromRGBO(184, 9, 72, 0.15),
                            borderRadius: BorderRadius.circular(25),
                            // поле ввода
                            child: TextField(
                              // параметр для того чтобы буквы стали звездами
                              controller: password,
                              obscureText: _obsecureText_2,

                              style: const TextStyle(
                                  color: Color.fromRGBO(186, 151, 161, 1)),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: (){
                                      setState(() {
                                        _obsecureText_2 =! _obsecureText_2;
                                      });
                                    }, icon: Icon(_obsecureText_2? Icons.visibility: Icons.visibility_off),
                                  ),
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

                          // кнопка входа
                          Container(
                              margin: EdgeInsets.only(top: 50),
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
                                onPressed: () async {
                                  var conn = await mysql().connect();
                                  String result = await enter_room().EnterRoom(id.text, password.text, conn);
                                  if (result == "")
                                    {
                                      Navigator.of(context).pushNamed('/choose_genre');
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
