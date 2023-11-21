import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget{
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
{
  @override
  Widget build(BuildContext context) {
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return Container(
      decoration: const BoxDecoration(
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
                    margin: EdgeInsets.only(top: 60),
                    child: SvgPicture.asset('assets/svg/app_logo.svg'),
                  ),

                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 2),
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
                      width: 350,
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text('Логин',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 23,
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
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(186, 151, 161, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                )
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
                                  color: mainTextColor),
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            obscuringCharacter: "*",
                            style: const TextStyle(
                                color: Color.fromRGBO(186, 151, 161, 1)),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye),
                                suffixIconColor: Color.fromRGBO(186, 151, 161, 1),
                                fillColor: Color.fromRGBO(255, 248, 246, 1),
                                filled: true,
                                hintText: 'Введите пароль',
                                hintStyle: const TextStyle(
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
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/main');
                                },
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
                                padding: EdgeInsets.only(top: 185),
                                child: Text('Нет аккаунта?',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway
                                    (fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: mainTextColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 185),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Color.fromRGBO(231, 104, 56, 1)
                                  ),
                                  onPressed: () {},
                                  child: Text('Зарегистрируйтесь',
                                    style: GoogleFonts.raleway
                                      (fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
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