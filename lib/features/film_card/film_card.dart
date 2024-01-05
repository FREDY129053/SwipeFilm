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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pattern1.png'),
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
          children: urlImages.asMap().entries.map((entry) => FilmCard(
            urlImage: entry.value,
            isFront: urlImages.last == entry.value,
          )).toList(),
        );
  }
}