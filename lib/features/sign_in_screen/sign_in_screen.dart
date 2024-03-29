import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_film/features/sign_in_screen/sign_in.dart';
// import 'package:swipe_film/features/waiting_room/snow_animation.dart';
// import 'package:flutter/services.dart';

import '../../mysql.dart';

int currUserId = 0;

class SignIn extends StatefulWidget{
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
{
  void updateError(String newError) {
    setState(() {
      error = '';
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        error = newError;
      });
    });
  }

  FocusNode _focusNode = FocusNode();
  bool _obsecureText = true;
  @override
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = "";

  Widget build(BuildContext context) {
    // Запрет переворота экрана в горизонтальный режим
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // адаптивка
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return GestureDetector(
      onTap: () {
      // This ensures that tapping anywhere on the screen dismisses the keyboard
      FocusScope.of(context).requestFocus(FocusNode());
    },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFF5F0E1),

        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  //звезда сверху
                  Transform.translate(
                    offset: const Offset(-160, 220),
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(30 / 360),
                      child: Opacity(
                        opacity: 0.5,
                        child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                      ),
                    ),
                  ),

                  // звезда снизу
                  Transform.translate(
                    offset: const Offset(170, 550),
                    child: ScaleTransition(
                      scale: const AlwaysStoppedAnimation(0.8),
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
                        child: Text('Войти',
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
                    child: Text('Войдите в свой аккаунт, чтобы\nпользоваться приложением',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway
                        (fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: mainTextColor),
                    ),
                  ),

                  //колонка из полей
                  Container(
                    //width: 350,
                      padding: EdgeInsets.only(
                          top: deviceHeight(context)*0.3,
                          left:deviceWidth(context)*0.07,
                          right: deviceWidth(context)*0.07),
                      child: Column(
                        children: [

                          // логин
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
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
                                fillColor: const Color.fromRGBO(255, 248, 246, 1),
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
                            padding: const EdgeInsets.only(top: 5, left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(error,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway
                                (fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(172, 31, 31, 1)),
                            ),
                          ),

                          // отступ
                          const SizedBox(
                            height: 20,
                          ),

                          // пароль
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
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
                            focusNode: _focusNode,
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
                                suffixIconColor: const Color.fromRGBO(186, 151, 161, 1),
                                fillColor: const Color.fromRGBO(255, 248, 246, 1),
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


                          // кнопка под паролем и подпись
                          Container(
                            alignment: Alignment.centerRight,
                            child:  TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: mainTextColor
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/easteregg');
                              },
                              child: const Text('Забыли пароль?'),
                            ),
                          ),


                          // кнопка входа
                          Container(
                              margin: EdgeInsets.only(top: deviceHeight(context)*0.05),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shadowColor: const Color.fromRGBO(184, 9, 72, 0.25),
                                  elevation: 10,
                                  backgroundColor: const Color.fromRGBO(231, 104, 56, 1),
                                  minimumSize: const Size(350, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                // ВХОД
                                onPressed: () async {
                                  if (_focusNode.hasFocus) {
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    FocusScope.of(context).requestFocus(_focusNode);
                                  }
                                  var conn = await mysql().connect();
                                  String result = await DBSignIn().SignInCheck(login.text, password.text, conn);
                                  if (result == "")
                                  {
                                    currUserId = await DBSignIn().GetUserId(login.text, conn);
                                    Future.delayed(Duration.zero, () {
                                      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                                    });
                                  }
                                  else
                                  {
                                    updateError(result);
                                  }
                                  await Future.delayed(const Duration(microseconds: 100000));
                                  conn.close();
                                },
                                child: Text('Войти',
                                  style: GoogleFonts.raleway
                                    (fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              )
                          ),

                          //ряд для текста и кнопки
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // текст
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

                              // кнопка для регистрации
                              Padding(
                                padding: EdgeInsets.only(top: deviceHeight(context)*0.01),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: const Color.fromRGBO(231, 104, 56, 1)
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/sign_up');
                                  },
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

                  //снег поверх всех элементов (ignorepointer чтобы перекрытия не было)
                  // const Positioned(
                  //   bottom: 0, // Установите это значение так, чтобы снег не перекрывал ваши звезды снизу
                  //   left: 0,
                  //   right: 0,
                  //   top: 0, // Обеспечьте, чтобы снег не перекрывал верхние элементы
                  //   child: IgnorePointer(
                  //     ignoring: true,
                  //     child: Snow(),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}