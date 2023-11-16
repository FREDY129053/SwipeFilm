import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  @override
  Widget build(BuildContext context) {
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/svg/Group 38_1.png')
          )
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 50),
                    child: SvgPicture.asset('assets/svg/app_logo.svg'),
                  ),

                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Регистрация',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway
                            (fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: mainTextColor),
                        ),
                      )
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Text('Для пользования приложением требуется\nналичие аккаунта',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway
                        (fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: mainTextColor),
                    ),
                  ),


                  Container(
                      width: MediaQuery.of(context).size.width*0.9,

                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            child: Text('Логин',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: mainTextColor),
                            ),
                          ),
                          TextField(
                            style: TextStyle(
                                color: Color.fromRGBO(186, 151, 161, 1)),
                            decoration: InputDecoration(
                                fillColor: Color.fromRGBO(255, 248, 246, 1),
                                filled: true,
                                hintText: 'Введите логин',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(186, 151, 161, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                )
                            ),
                          ),
                          SizedBox(
                            height:20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            // margin: EdgeInsets.only(right: 240),
                            child: Text('Пароль',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: mainTextColor),
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            obscuringCharacter: "*",
                            style: TextStyle(
                                color: Color.fromRGBO(186, 151, 161, 1)),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye),
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
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            // margin: EdgeInsets.only(right: 70),
                            child: Text('Подтвердите пароль',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: mainTextColor),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              obscureText: true,
                              obscuringCharacter: "*",
                              style: TextStyle(
                                  color: Color.fromRGBO(186, 151, 161, 1)),
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.remove_red_eye),
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

                          Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Color.fromRGBO(184, 9, 72, 0.25),
                                  elevation: 10,
                                  backgroundColor: Color.fromRGBO(231, 104, 56, 1),
                                  minimumSize: Size(350, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text('Создать аккаунт',
                                  style: GoogleFonts.raleway
                                    (fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              )
                          ),


                        ],
                      )
                  ),

                ],
              )
            ],
          )
      ),
    );
  }
}