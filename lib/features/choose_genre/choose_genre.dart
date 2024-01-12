import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../mysql.dart';
import '../sign_in_screen/sign_in_screen.dart';
import 'ChooseGenre.dart';

class ChooseGenre extends StatefulWidget {
  const ChooseGenre({Key? key}) : super(key: key);

  _ChooseGenreState createState() => _ChooseGenreState();
}

class _ChooseGenreState extends State<ChooseGenre>
{
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

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  String error = "";
  //виджет для выбора жанров
  Set<int> _selectedGenres = Set<int>();
  Widget genreButton(String text, int index) {  bool isSelected = _selectedGenres.contains(index);
  void toggleSelection() {
    setState(() {      if (isSelected) {
      _selectedGenres.remove(index);      } else {
      _selectedGenres.add(index);      }
    });  }

  // сами кнопки
  return ElevatedButton(
    onPressed: () {
      toggleSelection();    },
    child: Container(
      width: deviceWidth(context)*0.35,
      child: Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          color: isSelected ? Color(0xFF873B31) : Color(0xFF873B31),
          fontSize: 18.0,
          fontWeight: FontWeight.w600,),
      ),
    ),
    // Text(text,
    //   style: GoogleFonts.raleway(
    //     color: isSelected ? Color(0xFF873B31) : Color(0xFF873B31),
    //     fontSize: 18.0,
    //     fontWeight: FontWeight.w600,),
    // ),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      backgroundColor: isSelected ? Color.fromRGBO(223, 234, 255, 1) : Color(0xFFFFF8F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: isSelected ? Color(0xFF873B31) : Colors.transparent,
      ),
      elevation: 10,
      shadowColor: Color(0x33B80948),
    ),
  );
  }


  @override
  Widget build(BuildContext context) {
    // Запрет переворота экрана в горизонтальный режим
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final genres = arguments[0];
    final int roomID = arguments[1];
    final String pass = arguments[2];
    final bool isAdmin = arguments[3];

    List<Widget> buttonsList1 = [];
    List<Widget> buttonsList2 = [];
    for (int i = 0; i < genres.length ~/ 2; i++)
      {
        buttonsList1.add(genreButton(genres[i].name, genres[i].id));
      }
    for (int i = genres.length ~/ 2; i < genres.length; i++)
      {
        buttonsList2.add(genreButton(genres[i].name, genres[i].id));
      }
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F0E1),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // звезда сверху
              Transform.translate(
                offset: Offset(deviceWidth(context)*0.03, deviceHeight(context)*-0.29),
                child: Transform.scale(
                  scale: 1.2,
                  child: SvgPicture.asset('assets/svg/mainmenu_star1.svg'),
                ),
              ),
              // текст на звезде
              Container(
                padding: EdgeInsets.only(top: deviceHeight(context)*0.06),
                child: Text('Выберите\nжанры и\nдлительность',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color:  mainTextColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // звезда снизу
              Transform.translate(
                offset: Offset(deviceWidth(context)*0.37, deviceHeight(context)*0.75),
                child: Transform.scale(
                  scale: 0.8,
                  child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                ),
              ),

              //контейнер с жанрами
              Container(
                width: deviceWidth(context)*0.95,
                height: deviceHeight(context)*0.4,
                // padding: EdgeInsets.all(1),
                margin: EdgeInsets.only(top: deviceHeight(context)*0.32),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(184, 9, 72, 0.1),
                        spreadRadius: 0.5,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ]
                ),
                // лист жанров
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Минимум жанров: 5',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          color: Color(0xFF873B31),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // две колонки из жанров
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buttonsList1
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buttonsList2
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              //подпись при ошибке
              Container(
                padding: EdgeInsets.only(top: deviceHeight(context)*0.7),
                alignment: Alignment.center,
                child: Text(error,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway
                    (fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(172, 31, 31, 1)),
                ),
              ),
              // Container(
              //   width: deviceWidth(context)*0.9,
              //   height: deviceHeight(context)*0.12,
              //   // padding: EdgeInsets.all(1),
              //   margin: EdgeInsets.only(top: deviceHeight(context)*0.66),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(25),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Color.fromRGBO(184, 9, 72, 0.1),
              //           spreadRadius: 0.5,
              //           blurRadius: 10,
              //           offset: Offset(0, 3),
              //         ),
              //       ]
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Slider(
              //         value: hours.toDouble(),
              //         onChanged: (value){
              //           setState((){
              //             hours = value.toInt();
              //           });
              //         },
              //         min: 5,
              //         max: 100,
              //       ),
              //       Text(
              //         hours.toString() + " минут",
              //         style: const TextStyle(
              //           fontSize: 30.0,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //кнопка принять
              Container(
                  margin: EdgeInsets.only(top: deviceHeight(context)*0.8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color.fromRGBO(184, 9, 72, 0.25),
                      elevation: 10,
                      backgroundColor: Color.fromRGBO(255, 173, 15, 1),
                      minimumSize: Size(200, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {

                      if (_selectedGenres.length > 4)
                      {
                        await DBChooseGenre().GenresCommit(_selectedGenres, currUserId);
                        // await Future.delayed(Duration(microseconds: 1000000));
                        // if (tmp) {
                          Future.delayed(Duration.zero, () {
                            Navigator.pushNamedAndRemoveUntil(context, '/waiting_room', arguments: [roomID, pass, isAdmin], (route) => false);
                          });
                        // }

                      }
                      else
                      {
                        updateError("Выбрано меньше 5 жанров");
                      }
                    },
                    child: Text('ПРИНЯТЬ',
                      style: GoogleFonts.raleway
                        (fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}