import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_film/features/sign_up_screen/sign_up.dart';

import '../../mysql.dart';

class SignUp extends StatefulWidget{
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>
{
  // переменные для пароля
  bool _obsecureText = true;
  bool _obsecureText_2 = true;
  @override
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();
  String error = "";

  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF5F0E1),
        body: SingleChildScrollView(
          reverse: true,
          //padding: EdgeInsets.only(bottom: 5),
          child:
          Column(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  //звезда на фоне слева
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

                  // звезда снизу
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

                  // логотип
                  Container(
                    alignment: Alignment.topCenter,
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: deviceHeight(context)*0.07),
                    child: SvgPicture.asset('assets/svg/app_logo.svg'),
                  ),

                  // первый текст
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: deviceHeight(context)*0.18),
                        child: Text('Регистрация',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway
                            (fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: mainTextColor),
                        ),
                      )
                  ),

                  // второй текст
                  Container(
                    margin: EdgeInsets.only(top: deviceHeight(context)*0.23),
                    child: Text('Для пользования приложением\nтребуется наличие аккаунта',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway
                        (fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: mainTextColor),
                    ),
                  ),

                  // колонка полей
                  Container(
                      padding: EdgeInsets.only(
                          top: deviceHeight(context)*0.3,
                          left:deviceWidth(context)*0.07,
                          right: deviceWidth(context)*0.07),
                      child: Column(
                        children: [
                          // логин
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            child: Text('Логин',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 23,
                                  color: mainTextColor),
                            ),
                          ),
                          // поле для ввода логина
                          TextFormField(
                            controller: login,
                            style: const TextStyle(
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
                          // подпись об ошибке
                          Container(
                            padding: EdgeInsets.only(top: 5, left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(error,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromRGBO(172, 31, 31, 1)),
                            ),
                          ),
                          //отступ
                          const SizedBox(
                            height:15,
                          ),
                          // пароль
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            // margin: EdgeInsets.only(right: 240),
                            child: Text('Пароль',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 23,
                                  color: mainTextColor),
                            ),
                          ),
                          // поле для ввода пароля
                          TextFormField(
                            controller: password,
                            obscureText: _obsecureText,
                            //obscuringCharacter: "*",
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
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(186, 151, 161, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                )
                            ),
                          ),
                          //отступ
                          const SizedBox(
                            height: 30,
                          ),
                          // подтверждение пароля
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            // margin: EdgeInsets.only(right: 70),
                            child: Text('Подтвердите пароль',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w700,
                                  fontSize: 23,
                                  color: mainTextColor),
                            ),
                          ),
                          // поле для ввода пароля
                          Container(
                            child: TextFormField(
                              controller: passwordRepeat,
                              obscureText: _obsecureText_2,
                              //obscuringCharacter: "*",
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
                                  hintText: 'Введите пароль еще раз',
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(186, 151, 161, 1)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  )
                              ),
                            ),
                          ),


                          // кнопка создать аккаунт
                          Container(
                              margin: EdgeInsets.only(top: deviceHeight(context)*0.08),
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
                                // РЕГА
                                onPressed: () async {
                                  var conn = await mysql().connect();
                                  String result = await sign_up().sign_up_check(login.text, password.text, passwordRepeat.text, conn);
                                  if (result == "")
                                  {
                                    await sign_up().user_commit(login.text, password.text, conn);
                                    Navigator.of(context).pushNamed('/main');
                                  }
                                  else
                                  {
                                    error = await sign_up().sign_up_check(login.text, password.text, passwordRepeat.text, conn);
                                  }
                                  await Future.delayed(Duration(microseconds: 1000000));
                                  conn.close();
                                },
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
              ),




            ],
          ),
        ),
      ),
    );

  }
}