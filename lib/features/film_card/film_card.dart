import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_film/features/sign_in_screen/sign_in_screen.dart';
import 'package:swipe_film/on_changes/card_provider.dart';
import 'package:swipe_film/repo/models/FilmInfo.dart';

import '../../mysql.dart';
import '../../repo/films_list.dart';
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

  Stream<int> getChoice(int roomId) async* {
    while(true) {
      int tmp = 0;
      var conn = await mysql().connect();
      await Future.delayed(Duration(microseconds: 1000000));
      var result = await conn.query('''
      SELECT
        uc.choice
      FROM
        user_choice uc
      JOIN
        particians_of_rooms por ON uc.member_id = por.user_id
      WHERE
        por.room_id = ?
      GROUP BY
        uc.choice
      HAVING
        COUNT(*) = (
          SELECT
            COUNT(DISTINCT user_id)
          FROM
            particians_of_rooms
          WHERE
            room_id = ?
        )
    ''', [roomId, roomId]);
      tmp = result.isNotEmpty ? result.first['choice'] ?? 0 : 0;
      conn.close();

      yield tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    int theme = args[1];
    final StreamController<int> _controller1 = StreamController<int>();
    @override
    void dispose() {
      _controller1.close();
      super.dispose();
    }
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
      child: StreamBuilder<int>(
        stream: getChoice(args[0]),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          bool isStop = false;
          int i = 0;
          if (snapshot.hasData) {
            if (snapshot.data != 0) {
              print("Res = ${snapshot.data}");
              int? t = snapshot.data;
              FilmsList fl = FilmsList();
              FilmInfo? tmp;
              if (i != 0) {
                _controller1.add(0);
                i++;
              }
              if (t != null && i == 0) {
                fl.getFilmById(t).then((value) {
                  if (value != null) {
                    tmp = value;
                    _showConfetti();
                    _showConfetti();
                    i++;
                    print("${tmp!.id} return");
                    print("${tmp!.name} return");
                    print("${tmp!.country} return");
                    print("${tmp!.posterUrl} return");
                    print("${tmp!.year} return");
                    print("${tmp!.description} return");
                    return Scaffold(
                        backgroundColor: Colors.transparent,

                        //карточка
                        body: Stack(
                            children: [
                              FilmCard(
                                id: tmp!.id,
                                name: tmp!.name,
                                country: tmp!.country,
                                urlImage: tmp!.posterUrl,
                                year: tmp!.year,
                                description: tmp!.description,
                                genres: tmp!.genres,
                                duration: tmp!.duration,
                                isFront: true,
                                isFinal: true,
                              ),

                              // Align(
                              //   alignment: Alignment.bottomCenter,
                              //   child: ElevatedButton(
                              //     onPressed: () async {
                              //       var conn = await mysql().connect();
                              //       mysql().DeletePartician(conn, currUserId);
                              //       mysql().DeleteRoom(conn, args[0]);
                              //       conn.close();
                              //       Future.delayed(const Duration(milliseconds: 1000), () {
                              //         Navigator.pushNamedAndRemoveUntil(context, '/',  (route) => false);
                              //       });
                              //     },
                              //     style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFAD0F)),
                              //       elevation: MaterialStateProperty.all<double>(0),
                              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              //         RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(25.0),
                              //         ),
                              //       ),
                              //     ),
                              //     child: Text(
                              //       "На главную",
                              //       style: GoogleFonts.raleway(
                              //         color: Colors.white,
                              //         fontSize: 23,
                              //         fontWeight: FontWeight.w700,
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Align(
                                alignment: Alignment.center,
                                child: ConfettiWidget(
                                  confettiController: _controller,
                                  blastDirectionality: BlastDirectionality.explosive,
                                  shouldLoop: false,
                                  colors: const [Colors.blue, Colors.green, Colors.pink],
                                ),
                              ),
                            ]
                        )
                    );
                  }
                });
              }
            }
          }
          return Scaffold(
              backgroundColor: Colors.transparent,

              //карточка
              body: Stack(
                  children: [
                    buildCards(),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xFFFFF8F6),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.arrow_back, // другая иконка для "не нравится"
                                    size: 35,
                                    color: Color(0xFFFFC445),
                                  ),
                                  Icon(
                                    Icons.thumb_down, // другая иконка для "не нравится"
                                    size: 35,
                                    color: Color(0xFFFFC445),
                                  ),
                                  SizedBox(width: 5.0),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xFFFFF8F6),
                              ),
                              child: const Row(
                                children: [
                                  SizedBox(width: 5.0),
                                  Icon(
                                    Icons.thumb_up, // другая иконка для "не нравится"
                                    size: 35,
                                    color: Color(0xFFFFC445),
                                  ),
                                  Icon(
                                    Icons.arrow_forward, // другая иконка для "не нравится"
                                    size: 35,
                                    color: Color(0xFFFFC445),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: ConfettiWidget(
                        confettiController: _controller,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                        colors: const [Colors.blue, Colors.green, Colors.pink],
                      ),
                    ),
                  ]
              )
          );
        },
      )
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
    provider.i = films.length - 1;
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
                isFinal: false,
              )
          ).toList()
    );
  }
}