import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);

      return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 15),),
                    Container(

                      width: 138,
                      height: 138,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(184, 9, 72, 0.25).withOpacity(0.06),
                            spreadRadius: 1,
                            blurRadius: 30,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SvgPicture.asset('assets/svg/applogo_withshadow.svg'),
                    ),

                    // Padding(padding: EdgeInsets.only(top: 40),),
                    // SvgPicture.asset(
                    //   'assets/svg/app_logo.svg',
                    //   height: 138,
                    //   width: 138,
                    // ),
                    Padding(padding: EdgeInsets.only(top: 5),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: SvgPicture.asset('assets/svg/splash_titlestar.svg'),
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
                          child: SvgPicture.asset('assets/svg/splash_titlestar.svg'),
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
                    const Padding(padding: EdgeInsets.all(5),),
                    Text('Приложение, которое поможет Вам\n определиться, что посмотреть',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway
                        (fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: mainTextColor),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 100),),
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
                          onPressed: () {
                            Navigator.of(context).pushNamed('/sign_in');
                          },
                          child: Text('Войти',
                            style: GoogleFonts.raleway
                              (fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20),),
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
                          onPressed: () {
                            Navigator.of(context).pushNamed('/sign_up');
                          },
                          child: Text('Зарегистрироваться',
                            style: GoogleFonts.raleway
                              (fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )
                    ),
                  ],
                ),
                Positioned(
                  bottom: -180,
                  left: 0,
                  right: 0,
                  child: Transform.scale(
                    scale: 1.5,
                    child: SvgPicture.asset(
                      'assets/svg/splash_stars.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}