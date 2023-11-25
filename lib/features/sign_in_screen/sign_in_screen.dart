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
                      Transform.translate(
                        offset: Offset(-160, 220),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(30 / 360),
                          child: Opacity(
                            opacity: 0.5,
                            child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(170, 550),
                        child: ScaleTransition(
                          scale: AlwaysStoppedAnimation(0.8),
                          child: Opacity(
                            opacity: 0.5,
                            child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: deviceHeight(context)*0.07),
                        child: SvgPicture.asset('assets/svg/app_logo.svg'),
                      ),

                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: deviceHeight(context)*0.18),
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
                        margin: EdgeInsets.only(top: deviceHeight(context)*0.22),
                        child: Text('Войдите в свой аккаунт, чтобы\nпользоваться приложением',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway
                            (fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: mainTextColor),
                        ),
                      ),


                      Container(
                          //width: 350,
                          padding: EdgeInsets.only(
                              top: deviceHeight(context)*0.3,
                              left:deviceWidth(context)*0.07,
                              right: deviceWidth(context)*0.07),
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
                                  margin: EdgeInsets.only(top: deviceHeight(context)*0.05),
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
                                    padding: EdgeInsets.only(top: deviceHeight(context)*0.01),
                                    child: Text('Нет аккаунта?',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway
                                        (fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: mainTextColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: deviceHeight(context)*0.01),
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
                  ),

                ],
              ),
      );
  }
}