import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:swipe_film/features/sign_in_screen/sign_in_screen.dart';
import 'package:swipe_film/repo/films_list.dart';
import 'package:swipe_film/repo/models/FilmInfo.dart';

import '../mysql.dart';

enum CardStatus {like, dislike}

class CardProvider extends ChangeNotifier {
  late int roomId = 0;

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

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
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

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();
    print("Ok $roomId and $currUserId");
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

    _completer.complete(tmp);
    i = films.length - 1;

    notifyListeners();

    return _completer.future;
  }

}