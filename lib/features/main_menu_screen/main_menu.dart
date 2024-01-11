import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../mysql.dart';
import '../choose_genre/ChooseGenre.dart';
// import '../waiting_room/snow_animation.dart';

List<Genre> genres = [];

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
{
  @override
  Widget build(BuildContext context) {
    // Запрет переворота экрана в горизонтальный режим
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF5F0E1),
        body: Column(
          children: [
            //верхняя часть со звездой и текстом
            Transform.translate(
              offset: Offset(deviceWidth(context)*0.03, deviceHeight(context)*-0.28), // для того, чтобы звезда находилась наверху и была обрезана рамками экрана
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //звезда
                  Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset('assets/svg/mainmenu_star1.svg'),
                  ),

                  //текст на звезде
                  Transform.translate(
                    offset: Offset(-15, 110), // Adjust the value as necessary
                    child: Text(
                      "Меню комнат",
                      style: GoogleFonts.raleway(
                        color: Color(0xFF873B31),
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //колонна из двух кнопок
            Transform.translate(
              offset: Offset(0, -deviceHeight(context)*0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: deviceWidth(context)*0.85, // Specify your desired width here
                    child: ElevatedButton(
                      onPressed: () async {
                        var conn = await mysql().connect();
                        genres = await DBChooseGenre().GetGenres(conn);
                        Navigator.of(context).pushNamed('/create_room', arguments: genres);
                      },
                      child: Text(
                        "СОЗДАТЬ КОМНАТУ",
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE76838)), // фоновый цвет кнопки
                        elevation: MaterialStateProperty.all<double>(0), // удаление дефолтной тени
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0), // округление краев
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 80)), //расстояние между кнопками

                  //кнопка влететь в комнату
                  Container(
                    height: 55,
                    width: deviceWidth(context)*0.85400, // Specify your desired width here
                    child: ElevatedButton(
                      onPressed: () async {
                        var conn = await mysql().connect();
                        genres = await DBChooseGenre().GetGenres(conn);
                        Navigator.of(context).pushNamed('/enter_room', arguments: genres);
                      },
                      child: Text(
                        "ВЛЕТЕТЬ В КОМНАТУ",
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFAD0F)),
                        elevation: MaterialStateProperty.all<double>(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //декоративная звезда снизу
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: FractionallySizedBox(
                  alignment: Alignment.bottomRight,
                  widthFactor: 0.3, // регулируйте это значение для смещения изображения вправо
                  heightFactor: 0.8,
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: Transform.scale(
                      scale: 0.8, // регулируйте это значение для уменьшения масштаба звезды
                      child: SvgPicture.asset('assets/svg/mainmenu_star2.svg'),
                    ),
                  ),
                ),
              ),
            ),
            // IgnorePointer(
            //   ignoring: true, //true, чтобы разрешить взаимодействие
            //   child: Snow(),
            // ),
          ],
        ),
      );
  }
}
