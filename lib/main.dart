import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(245, 240, 225, 1),
          // textTheme: TextTheme(
          //   // Тема для больших заголовков
          //   bodyLarge: TextStyle(
          //   fontWeight: FontWeight.w700,
          //     fontSize: 32,
          //     color: mainTextColor,
          //   ),
          //   // Тема для подписей
          //   bodySmall: TextStyle(
          //     fontWeight: FontWeight.w500,
          //     fontSize: 14,
          //     color: mainTextColor,
          //   ),
          // ),
      ),

      home: Scaffold(
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Container(
                    width: 138,
                    height: 138,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(184, 9, 72, 0.25).withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 30,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                        image: Svg(
                          'assets/svg/app_logo.svg',
                        ),
                      ),
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 40),),
                  // SvgPicture.asset(
                  //   'assets/svg/app_logo.svg',
                  //   height: 138,
                  //   width: 138,
                  // ),
                  Padding(padding: EdgeInsets.only(top: 5),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Svg(
                              'assets/svg/star.svg',
                            ),
                          ),
                        ),
                      ),
                      Text('Добро пожаловать\n в SwipeFilm',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway
                          (fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: mainTextColor),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Svg(
                              'assets/svg/star.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // row для звезд и текста
                  // Padding(padding: EdgeInsets.all(2),),
                  // Text('Добро пожаловать\n в SwipeFilm',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.raleway
                  //     (fontWeight: FontWeight.w700,
                  //       fontSize: 26,
                  //       color: mainTextColor),
                  // ),
                  Padding(padding: EdgeInsets.all(5),),
                  Text('Приложение, которое поможет Вам\n определиться, что посмотреть',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway
                      (fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: mainTextColor),
                  ),
                  Padding(padding: EdgeInsets.only(top: 80),),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Color.fromRGBO(184, 9, 72, 0.25),
                        elevation: 10,
                        backgroundColor: Color.fromRGBO(231, 104, 56, 1),
                        minimumSize: Size(320, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
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
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Color.fromRGBO(184, 9, 72, 0.25),
                          elevation: 10,
                          backgroundColor: Color.fromRGBO(255, 173, 15, 1),
                          minimumSize: Size(320, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Зарегистрироваться',
                          style: GoogleFonts.raleway
                            (fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 206,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Svg(
                          'assets/svg/stars.svg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                 ]
              )
            ]
          )
        ),
      ),
    );
  }
}