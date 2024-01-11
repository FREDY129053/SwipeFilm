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
    final args = ModalRoute.of(context)!.settings.arguments as List;
    int theme = args[1];
    //фон
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: theme == 0
              ? const AssetImage('assets/images/pattern1.png')
              : const AssetImage('assets/images/pattern1_anime.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        //карточка
        body: buildCards(),
      ),
    );
  }

  // TEST
  Widget buildCards() {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final provider = Provider.of<CardProvider>(context);
    Future.delayed(const Duration(microseconds: 1), () {});
    provider.theme = args[1];
    provider.roomId = args[0];
    final films = provider.films;
    print("Lenght = ${films.length}");

    return films.isEmpty
      ? Center(
          child: ElevatedButton(
            onPressed: () {
              final provider = Provider.of<CardProvider>(context, listen: false);
              provider.test(args[0], args[1]);
            },
            child: Text('Заново'),
          ),
        )

      : Stack(
          children: films.map((resultFilm) =>
              FilmCard(
                id: resultFilm.id,
                name: resultFilm.name,
                country: resultFilm.country,
                urlImage: resultFilm.posterUrl,
                year: resultFilm.year,
                description: resultFilm.description,
                genres: resultFilm.genres,
                duration: resultFilm.duration,
                isFront: films.last == resultFilm,
              )
          ).toList()
        );
  }
}