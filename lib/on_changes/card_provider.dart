import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:swipe_film/features/film_card/film_card.dart';
import 'package:swipe_film/features/sign_in_screen/sign_in_screen.dart';
import 'package:swipe_film/repo/films_list.dart';
import 'package:swipe_film/repo/models/FilmInfo.dart';

import '../mysql.dart';

enum CardStatus {like, dislike}

class CardProvider extends ChangeNotifier {
  late int roomId = 0;
  late int choice = 0;

  List<FilmInfo> films = [];

  bool _isDrag = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  // List<FilmInfo> get filmsList => films;
  bool get isDragging => _isDrag;
  Offset get position => _position;
  double get angle => _angle;

  int i = -1;
  bool next = false;
  int count = 1;

  final Completer<List<FilmInfo>> _completer = Completer<List<FilmInfo>>();

  CardProvider() {
    // Future.delayed(Duration.zero, (){
    //   test(roomId);
    // });
  }

  void setScreenSize(Size size) => _screenSize = size;

  void startPosition(DragStartDetails details) {
    _isDrag = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) async {
    print("I = $i");
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  Future<int> getChoice(int roomId) async {
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
    tmp = result.first['choice'] ?? 0;
    conn.close();

    return tmp;
  }

  void endPosition() {
    _isDrag = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDrag = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _position.dx;
    const delta = 100;

    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    }
  }

  Future<void> like() async {
    choice = films[i].id;
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();
    print("Ok $roomId and $currUserId and $choice");
    var conn = await mysql().connect();
    await Future.delayed(const Duration(microseconds: 10));
    await conn.query("INSERT INTO user_choice(member_id, choice) VALUES(?, ?)", [currUserId, choice]);
    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();
    print("Not OK");
    notifyListeners();
  }

  Future _nextCard() async {
    if (films.isEmpty) {
      return;
    }

    await Future.delayed(const Duration(milliseconds: 200));
    films.removeLast();
    i--;
    resetPosition();
  }

  Future<List<FilmInfo>> test(int roomID) async {
    var conn = await mysql().connect();
    await Future.delayed(Duration(microseconds: 1000000));
    var query = await conn.query('SELECT theme FROM rooms WHERE id = ?', [roomID]);
    int theme = int.parse(query.first['theme'].toString());
    List<FilmInfo> tmp = await FilmsList().getFilmsList(roomID, theme);
    for (var ii in tmp) {
      films.add(ii);
    }
    // var tmp = await conn.query('SELECT theme FROM rooms WHERE id = ?', [roomID]);
    _completer.complete(tmp);

    // List<FilmInfo> r = [
    // FilmInfo(
    //   id: 447301,
    //   name: "Начало",
    //   country: "США",
    //   posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //   year: 2010,
    //   description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //   genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //   duration: 148,),
    //
    //   FilmInfo(
    //     id: 447301,
    //     name: "Начало",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,
    //   ),
    //
    //   FilmInfo(
    //     id: 927898,
    //     name: "Переводчик",
    //     country: "Великобритания",
    //     posterUrl: "https://imagetmdb.com/t/p/original/eTvN54pd83TrSEOz6wbsXEJktCV.jpg",
    //     year: 2022,
    //     description: "Ахмед спас Джона от смерти, и теперь тот должен вернуть долг. Гай Ричи как никогда серьезен — и как всегда крут",
    //     genres: ["боевик","триллер", "военный", "история", "драма"],
    //     duration: 123,
    //   ),
    //   FilmInfo(
    //     id: 447301,
    //     name: "Начало",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,),
    //
    //   FilmInfo(
    //     id: 447301,
    //     name: "Начало",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,
    //   ),
    //
    //   FilmInfo(
    //     id: 927898,
    //     name: "Переводчик",
    //     country: "Великобритания",
    //     posterUrl: "https://imagetmdb.com/t/p/original/eTvN54pd83TrSEOz6wbsXEJktCV.jpg",
    //     year: 2022,
    //     description: "Ахмед спас Джона от смерти, и теперь тот должен вернуть долг. Гай Ричи как никогда серьезен — и как всегда крут",
    //     genres: ["боевик","триллер", "военный", "история", "драма"],
    //     duration: 123,
    //   ),
    //   FilmInfo(
    //     id: 447301,
    //     name: "Начало",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,),
    //
    //   FilmInfo(
    //     id: 447301,
    //     name: "Начало",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,
    //   ),
    //
    //   FilmInfo(
    //     id: 927898,
    //     name: "Переводчик",
    //     country: "Великобритания",
    //     posterUrl: "https://imagetmdb.com/t/p/original/eTvN54pd83TrSEOz6wbsXEJktCV.jpg",
    //     year: 2022,
    //     description: "Ахмед спас Джона от смерти, и теперь тот должен вернуть долг. Гай Ричи как никогда серьезен — и как всегда крут",
    //     genres: ["боевик","триллер", "военный", "история", "драма"],
    //     duration: 123,
    //   ),
    //   FilmInfo(
    //     id: 447301,
    //     name: "Начало",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,),
    //
    //   FilmInfo(
    //     id: 447301,
    //     name: "Хуета",
    //     country: "США",
    //     posterUrl: "https://imagetmdb.com/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
    //     year: 2010,
    //     description: "Профессиональные воры внедряются в сон наследника огромной империи. Фантастический боевик Кристофера Нолана",
    //     genres: ["фантастика", "боевик", "триллер", "драма", "детектив"],
    //     duration: 148,
    //   ),
    //
    //   FilmInfo(
    //     id: 927898,
    //     name: "Хуета1",
    //     country: "Великобритания",
    //     posterUrl: "https://imagetmdb.com/t/p/original/eTvN54pd83TrSEOz6wbsXEJktCV.jpg",
    //     year: 2022,
    //     description: "Ахмед спас Джона от смерти, и теперь тот должен вернуть долг. Гай Ричи как никогда серьезен — и как всегда крут",
    //     genres: ["боевик","триллер", "военный", "история", "драма"],
    //     duration: 123,
    //   ),
    //
    // ];

    notifyListeners();
    return _completer.future;
    // return r;
  }

}