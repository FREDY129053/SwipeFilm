import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_film/features/create_room_screen/CreateRoom.dart';
import 'package:swipe_film/features/enter_room_screen/EnterRoom.dart';
import 'package:swipe_film/features/sign_in_screen/sign_in_screen.dart';
import 'package:swipe_film/mysql.dart';

import '../choose_genre/ChooseGenre.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<CreateRoom> {
  void updateError(String newError) {
    setState(() {
      error = '';
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        error = newError;
      });
    });
  }

  bool _obsecureText = true;
  TextEditingController password = TextEditingController();
  String error = "";

  int _peopleValue = 2;
  int _genreValue = 0; //id 0 - фильм, 1 - сериал, 2 - аниме программисты если что меняйте под себя

  //кастомные кнопки выбора (радио-кнопки),
  // на входе получают строку с текстом, который отображается в кнопке
  //и index значение, на которое нужно заменить значение выбора
  Widget peopleNumberButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _peopleValue = index;
        });
      },
      child: Text(
        text,
        style: GoogleFonts.raleway(
          color: Color(0xFF873B31),
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: (_peopleValue == index) ? Color(0xFFFFAD0F) : Color(
            0xFFFFF8F6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(
            color: (_peopleValue == index) ? Color(0xFF873B31) : Colors
                .transparent),
        elevation: 10,
        shadowColor: Color(0x33B80948),
      ),
    );
  }

  //вариант кнопки для категорий контента
  Widget genreButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _genreValue = index;
        });
      },
      child: Text(
        text,
        style: GoogleFonts.raleway(
          color: Color(0xFF873B31),
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        backgroundColor: (_genreValue == index) ? Color(0xFFFFAD0F) : Color(
            0xFFFFF8F6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(
            color: (_genreValue == index) ? Color(0xFF873B31) : Colors
                .transparent),
        elevation: 10,
        shadowColor: Color(0x33B80948),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Запрет переворота экрана в горизонтальный режим
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F0E1),
        body: SingleChildScrollView(
          child: Transform.translate(
            offset: Offset(0, -(MediaQuery.of(context).size.height * 0.18)),
            child: Column(
              children: <Widget>[

                //верхняя часть(звезда и надпись в ней Создать комнату)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(deviceWidth(context)*0.03, deviceHeight(context)*-0.05),
                      child: Transform.scale(
                        scale: 1.2,
                        child: SvgPicture.asset('assets/svg/mainmenu_star1.svg',
                        width: MediaQuery.of(context).size.width,),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, (MediaQuery.of(context).size.height * 0.07)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   child: Icon(
                            //     Icons.arrow_back,
                            //     color: Color(0xFF873B31),
                            //   ),
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Color(0xFFF5F0E1),
                            //     shape: CircleBorder(),
                            //     padding: EdgeInsets.all(10),
                            //     elevation: 10,
                            //     shadowColor: Color(0x33B80948),
                            //   ),
                            // ),
                            //SizedBox(width: 10),
                            // Adjust the space between elements
                            Text(
                              "Создать\nкомнату",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                color: Color(0xFF873B31),
                                fontSize: 32.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            // Icon(Icons.add, color: Colors.transparent),
                            // Icon(Icons.add, color: Colors.transparent), это нужно для того, чтобы текст был ближе к центру
                          ],
                        ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                //основные настройки комнаты

                //подпись Сколько человек?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.0),
                    // Значение отступа можно изменить под свои нужды
                    child: Text(
                      "Сколько человек?",
                      style: GoogleFonts.raleway(
                        color: Color(0xFF873B31),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //выбор количества человек
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    peopleNumberButton("2", 2),
                    peopleNumberButton("3", 3),
                    peopleNumberButton("4", 4),
                    peopleNumberButton("5", 5),
                    peopleNumberButton("6", 6),
                  ],
                ),
                SizedBox(height: 10),


                //выбор категории контента
                Container(
                  color: Color(0xFFFFF8F6),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Что будете смотреть?",
                          style: GoogleFonts.raleway(
                            color: Color(0xFF873B31),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      //кнопки выбора контента
                      SizedBox(height: 10),
                      genreButton("Фильм", 0),
                      // SizedBox(height: 10),
                      // genreButton("Сериал", 1),
                      SizedBox(height: 10),
                      genreButton("Аниме", 2),
                    ],
                  ),
                ),

                //пароль
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                    // Значение отступа можно изменить под свои нужды
                    child: Text(
                      "Придумайте пароль",
                      style: GoogleFonts.raleway(
                        color: Color(0xFF873B31),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8F6),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(184, 9, 72, 0.15),
                        blurRadius: 19,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: _obsecureText,
                    controller: password,
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
                        hintText: 'Введите пароль',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(186, 151, 161, 1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 25),

                //кнопка создать комнату
                ElevatedButton(
                  onPressed: () async {
                    if (password.text != "")
                      {
                        var conn = await mysql().connect();
                        int roomId = await DBCreateRoom().RoomCommit(currUserId ,_peopleValue, _genreValue, password.text, conn);
                        await Future.delayed(const Duration(microseconds: 500000));
                        await DBEnterRoom().CommitRoomPartician(roomId, currUserId, true, conn);
                        final genres = ModalRoute.of(context)!.settings.arguments as List<Genre>;
                        Future.delayed(Duration.zero, () {
                          Navigator.pushNamedAndRemoveUntil(context, '/choose_genre', arguments: [genres, roomId, password.text, true], (route) => false);
                        });
                        conn.close();
                      }
                    else
                      {
                         updateError("Введите пароль");
                      }
                  },
                  child: Text(
                    "СОЗДАТЬ КОМНАТУ",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(12),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF7AA6FF)),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


