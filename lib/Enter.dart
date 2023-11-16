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
                        margin: EdgeInsets.only(top: 80),
                        child: SvgPicture.asset('assets/svg/app_logo.svg'),
                      ),

                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text('Войти',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                  color: mainTextColor),
                            ),
                          )
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text('Войдите в свой аккаунт, чтобы пользоваться\n приложением',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway
                            (fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: mainTextColor),
                        ),
                      ),

                  Container(
                    margin: EdgeInsets.only(top: 20, right: 250),
                    child: Text('Логин',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway
                        (fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: mainTextColor),
                    ),
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
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
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          margin: EdgeInsets.only(right: 240),
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
                        Container(
                          alignment: Alignment.centerRight,
                          child:  TextButton(
                            child: Text('Забыли пароль?'),
                            style: TextButton.styleFrom(
                                foregroundColor: mainTextColor
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
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
                              child: Text('Войти',
                                style: GoogleFonts.raleway
                                  (fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Padding(
                                padding: EdgeInsets.only(top: 200),
                                child: Text('Нет аккаунта?',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway
                                    (fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: mainTextColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 200),
                                child: TextButton(
                                  child: Text('Зарегистрируйтесь',
                                    style: GoogleFonts.raleway
                                      (fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        ),
                                  ),
                                  style: TextButton.styleFrom(
                                      foregroundColor: Color.fromRGBO(231, 104, 56, 1)
                                  ),
                                  onPressed: () {},
                                ),
                              )
                          ],
                        )

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