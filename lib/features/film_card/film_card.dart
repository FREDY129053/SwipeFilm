//import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_film/on_changes/card_provider.dart';

import 'film_card_class.dart';

class FilmCards extends StatefulWidget {
  const FilmCards({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}


class _MainMenuState extends State<FilmCards> {
  @override
  Widget build(BuildContext context) {

    //фон
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pattern1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        //карточка
        body: buildCards(),
      )
    );
  }

  // TEST
  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    Future.delayed(const Duration(microseconds: 1), () {});
    final urlImages = provider.urlImages;

    return urlImages.isEmpty
      ? Center(
          child: ElevatedButton(
            onPressed: () {
              final provider = Provider.of<CardProvider>(context, listen: false);
              provider.test();
            },
            child: Text('Заново'),
          ),
        )

      : Stack(
          children: urlImages
            .map((urlImageI) => FilmCard(
            urlImage: urlImageI,
            isFront: urlImages.last == urlImageI,
          )).toList(),
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
  Widget _buildMinuteContainer(int episodeCount) {
    String episodeText;

    //русский язык
    if (episodeCount == 1) {
      episodeText = 'минута';
    } else if (episodeCount >= 2 && episodeCount <= 4 ||
        (episodeCount >= 21 && episodeCount % 10 >= 2 && episodeCount % 10 <= 4)) {
      episodeText = 'минуты';
    } else {
      episodeText = 'минут';
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