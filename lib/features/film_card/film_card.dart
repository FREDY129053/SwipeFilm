import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_film/on_changes/card_provider.dart';
import 'package:swipe_film/repo/models/FilmInfo.dart';

import 'film_card_class.dart';

class FilmCards extends StatefulWidget {
  const FilmCards({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}


class _MainMenuState extends State<FilmCards> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showConfetti() {
    _controller.play();
  }

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
        body: Stack(
          children: [
            buildCards(),

            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 35.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Container(
            //             padding: const EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(50),
            //               color: Color(0xFFFFF8F6),
            //             ),
            //             child: const Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 Icon(
            //                   Icons.arrow_back, // другая иконка для "не нравится"
            //                   size: 35,
            //                   color: Color(0xFFFFC445),
            //                 ),
            //                 Icon(
            //                   Icons.thumb_down, // другая иконка для "не нравится"
            //                   size: 35,
            //                   color: Color(0xFFFFC445),
            //                 ),
            //                 SizedBox(width: 5.0),
            //               ],
            //             ),
            //           ),
            //         Container(
            //             padding: const EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(50),
            //               color: const Color(0xFFFFF8F6),
            //             ),
            //             child: const Row(
            //               children: [
            //                 SizedBox(width: 5.0),
            //                 Icon(
            //                   Icons.thumb_up, // другая иконка для "не нравится"
            //                   size: 35,
            //                   color: Color(0xFFFFC445),
            //                 ),
            //                 Icon(
            //                   Icons.arrow_forward, // другая иконка для "не нравится"
            //                   size: 35,
            //                   color: Color(0xFFFFC445),
            //                 ),
            //               ],
            //             ),
            //           ),
            //       ],
            //     ),
            //   ),
            // ),

            // Align(
            //   alignment: Alignment.center,
            //   child: ConfettiWidget(
            //     confettiController: _controller,
            //     blastDirectionality: BlastDirectionality.explosive,
            //     shouldLoop: false,
            //     colors: const [Colors.blue, Colors.green, Colors.pink],
            //   ),
            // ),
          ]
        )
      ),
    );
  }

  // TEST
  Widget buildCards() {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final provider = Provider.of<CardProvider>(context);
    provider.films = args[2];
    Future.delayed(const Duration(microseconds: 1), () {});
    provider.roomId = args[0];
    final List<FilmInfo> films = provider.films;
    print("Lenght = ${films.length}");

    return films.isEmpty
      ? Center(
          child: ElevatedButton(
            onPressed: () {
              final provider = Provider.of<CardProvider>(context, listen: false);
              // provider.test(args[0]);
            },
            child: Text('Заново'),
          ),
        )

      : Stack(
          children: films.map<Widget>((resultFilm) =>
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