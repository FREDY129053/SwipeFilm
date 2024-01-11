import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../on_changes/card_provider.dart';

class FilmCard extends StatefulWidget {
  final int id;
  final String name;
  final String country;
  final String urlImage;
  final int year;
  final String description;
  final List<String> genres;
  final int duration;
  final bool isFront;

  const FilmCard({
    Key? key,
    required this.id,
    required this.name,
    required this.country,
    required this.urlImage,
    required this.year,
    required this.description,
    required this.genres,
    required this.duration,
    required this.isFront,
  }) : super(key: key);

  @override
  State<FilmCard> createState() => _FilmCardState();

}

class _FilmCardState extends State<FilmCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: widget.isFront ? buildFrontCard() : buildCard(),
  );

  Widget buildFrontCard() => GestureDetector(
    child: LayoutBuilder(
      builder: (context, constraits) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;

        final animationDuration = provider.isDragging ? 0 : 400;

        final center = constraits.smallest.center(Offset.zero);
        final rotateAngle = provider.angle * pi / 180;
        final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(rotateAngle)
          ..translate(-center.dx, -center.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: animationDuration),
          transform: rotatedMatrix..translate(position.dx, position.dy),
          child:  buildCard(),
        );
      },
    ),
    onPanStart: (details) {
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.startPosition(details);
    },
    
    onPanUpdate: (details) {
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.updatePosition(details);
    },

    onPanEnd: (details) {
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.endPosition();
    },
  );

  // Построение карточки
  Widget buildCard() => Center(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F6),
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: MediaQuery.of(context).size.width * 0.95, //ширина карточки
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0), //скругленные края
              child:
                CachedNetworkImage(
                  imageUrl: widget.urlImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
            ),
          ),

          const SizedBox(height: 10.0),

          //название
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: const Color(0xFF873A31),
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),

          //страна, год
          Text(
            "${widget.country}, ${widget.year}",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: const Color(0xFF873B31),
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20.0),

          //описание
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8F6),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: const Color(0xFF873B31)),
            ),
            child: Text(
              widget.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                color: const Color(0xFF873B31),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 20.0),

          //список жанров
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 8.0,
            children: _buildGenreContainer(widget.genres),
          ),
          const SizedBox(height: 20.0),
          //количество минут
          _buildMinuteContainer(widget.duration),
          const SizedBox(height: 20.0),
        ],
      ),
    ),
  );

  // Отображение жанров
  List<Widget> _buildGenreContainer(List<String> itemGenres) {
    List<Widget> genresContainer = [];
    itemGenres.forEach((text) {
      double horizontalPadding = 15.0;
      if (text.length > 10) {
        horizontalPadding = 10.0; // меньшие отступы по бокам если текст длинный
      }

      genresContainer.add(
        Container(
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
        )
      );
    });

    return genresContainer;
  }

  //виджет для отображения количества серий (принимает число серий)
  Widget _buildMinuteContainer(int episodeCount) {
    String episodeText;

    //русский язык
    if (episodeCount == 1) {
      episodeText = 'минута';
    } else if (episodeCount == 999999) {
      episodeText = 'многосерийный';
    } else if (episodeCount >= 2 && episodeCount <= 4 ||
        (episodeCount >= 21 && episodeCount % 10 >= 2 && episodeCount % 10 <= 4)) {
      episodeText = 'минуты';
    } else {
      episodeText = 'минут';
    }
    final String episodeInString = episodeCount == 999999 ? '' : episodeCount.toString();

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
            episodeInString,
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