import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../on_changes/card_provider.dart';

class FilmCard extends StatefulWidget {
  final String urlImage;
  final bool isFront;

  const FilmCard({
    Key? key,
    required this.urlImage,
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
              // Вывод картинки
              Image.network(
                widget.urlImage, // URL изображения (динамический)
                fit: BoxFit.cover,
                // Позволяет показывать загрузку
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
              ),
              // Image.asset(
              //   widget.urlImage, //путь к картинке (ИЗМЕНЯЕМОЕ)
              //   fit: BoxFit.cover,
              // ),
            ),
          ),

          const SizedBox(height: 10.0),

          //название
          Text(
            'Название фильма',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: const Color(0xFF873A31),
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),

          //страна, год
          Text(
            'Страна, год',
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
              'Мальчик-озорник задает жару грабителям. Лучшая комедия для создания праздничного настроения у всей семьи.',
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
            children: [
              _buildGenreContainer('Мелодрама'),
              _buildGenreContainer('История'),
              _buildGenreContainer('Триллер'),
              // добавляйте больше если нужно
            ],
          ),


          const SizedBox(height: 20.0),



          //количество минут
          _buildMinuteContainer(128),

          const SizedBox(height: 20.0),



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
  );

  // Отображение жанров
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