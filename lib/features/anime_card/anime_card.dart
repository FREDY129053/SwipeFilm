//import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeCard extends StatefulWidget {
  const AnimeCard({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}


class _MainMenuState extends State<AnimeCard> {
  @override
  Widget build(BuildContext context) {

    //фон
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fon.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        //карточка
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8F6),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(184, 9, 72, 0.15),
                  blurRadius: 19,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.95, //ширина карточки
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), //скругленные края
                    child: Image.asset(
                      'assets/images/homealone.png', //путь к картинке
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),

                //название
                Text(
                  'Название фильма',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: Color(0xFF873A31),
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                //страна, год
                Text(
                  'Страна, год',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: Color(0xFF873B31),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20.0),

                //описание
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.5),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8F6),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Color(0xFF873B31)),
                  ),
                  child: Text(
                    'Мальчик-озорник задает жару грабителям. Лучшая комедия для создания праздничного настроения у всей семьи.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      color: Color(0xFF873B31),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 20.0),

                //список жанров
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10.0,
                  runSpacing: 8.0,
                  children: [
                    _buildGenreContainer('Приключения'),
                    _buildGenreContainer('Экшен'),
                    _buildGenreContainer('Фэнтези'),
                    // добавляйте больше если нужно
                  ],
                ),


                SizedBox(height: 20.0),



                //количество серий
                _buildEpisodeContainer(128),

                SizedBox(height: 20.0),



                //SizedBox(height: 20.0),


                // SizedBox(height: 20.0), // Adjust this spacing as needed
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         // Action for the close button
                //       },
                //       icon: Icon(Icons.close, size: 40.0),
                //       iconSize: 40.0,
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         // Action for the like button
                //       },
                //       icon: Icon(Icons.favorite, size: 40.0),
                //       iconSize: 40.0,
                //       color: Colors.red,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //виджет для отображения жанров (принимает строку с названием жанра)
  Widget _buildGenreContainer(String text) {
    double horizontalPadding = 15.0;
    if (text.length > 10) {
      horizontalPadding = 10.0; // меньшие отступы по бокам если текст длинный
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Color.fromRGBO(223, 234, 255, 1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF873B31)),
      ),
      child: Text(
        text,
        style: GoogleFonts.raleway(
          color: Color(0xFF873B31),
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  //виджет для отображения количества серий (принимает число серий)
  Widget _buildEpisodeContainer(int episodeCount) {
    String episodeText;

    //русский язык
    if (episodeCount == 1) {
      episodeText = 'серия';
    } else if (episodeCount >= 2 && episodeCount <= 4 ||
        (episodeCount >= 21 && episodeCount % 10 >= 2 && episodeCount % 10 <= 4)) {
      episodeText = 'серии';
    } else {
      episodeText = 'серий';
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Color(0xFFE76838),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            episodeCount.toString(),
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4.0),
          Text(
            episodeText,
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }



}