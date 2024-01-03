import 'package:flutter/cupertino.dart';
import 'package:swipe_film/repo/films_list.dart';

enum CardStatus {like, dislike}

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];

  bool _isDrag = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDrag;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    Future.delayed(Duration.zero, (){
      test();
    });
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

    if (status != null) {
      print(status.toString().toUpperCase());
    }

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

    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if (_urlImages.isEmpty) {
      return;
    }

    await Future.delayed(Duration(milliseconds: 200));
    _urlImages.removeLast();

    resetPosition();
  }

  Future<bool> test() async {
    // _urlImages = [];
    _urlImages = <String>[
    'https://imagetmdb.com/t/p/original/yZIjfRdBOjOXK6X46IuvmGn7zJE.jpg',
    'https://imagetmdb.com/t/p/original/k9r86oHFo06ZC21zw2FkRD9wcJX.jpg',
    'https://imagetmdb.com/t/p/original/qdIMHd4sEfJSckfVJfKQvisL02a.jpg',
    'https://imagetmdb.com/t/p/original/rzdPqYx7Um4FUZeD8wpXqjAUcEm.jpg',
    'https://imagetmdb.com/t/p/original/2X3LAgxlxFVoSeSA1DQut7Cm4gx.jpg',
    'https://imagetmdb.com/t/p/original/iSIq6uabpr7DKw4RCF4Q0S7kh21.jpg',
    'https://imagetmdb.com/t/p/original/qkurjJVQUs4u417GfiMAKlurkcM.jpg',
    'https://imagetmdb.com/t/p/original/wgvc3PmjQGtYYDWaeuV867mnFDs.jpg',
    'https://imagetmdb.com/t/p/original/fQQRAYtE76T0LZxV1wTGk5kPOq.jpg',
    'https://imagetmdb.com/t/p/original/7py8kUCYaOdFn1TfVS87BDBySOz.jpg',
    'https://avatars.mds.yandex.net/get-ott/239697/2a000001800b131e914ef69b9b828f841166/orig',
    'https://imagetmdb.com/t/p/original/7sM6o7BuP2AXrMYvUPjRy8TvJrd.jpg',
    'https://imagetmdb.com/t/p/original/kx2YVkcsnTnmF9XGTAj2NqEcHFG.jpg',
    'https://imagetmdb.com/t/p/original/ttBydD0SynC0TMkW3AcnmsySkLp.jpg',
    'https://imagetmdb.com/t/p/original/zbpZOYrRCxEF8lFT5JC8XodEggC.jpg',
    'https://imagetmdb.com/t/p/original/ojgXOhVi9Yk8irDpRfDkIzdD1LK.jpg',
    'https://imagetmdb.com/t/p/original/zywtNiaZ9r7azrcNdl2j0jOgrkw.jpg',
    'https://imagetmdb.com/t/p/original/jz9Kep0xWjiA6QDHSsd43ASxNfj.jpg',
    'https://imagetmdb.com/t/p/original/sGEqHTylawwS6hwKultk1mKUjdB.jpg',
    'https://imagetmdb.com/t/p/original/9Ebn8atCcGk5OZrx4xmoTobAxoh.jpg',
    'https://imagetmdb.com/t/p/original/tb440cwQMRoVHnhYJlzlxfv1ikm.jpg',
    'https://imagetmdb.com/t/p/original/a5pOEjOLvr04Hr8qktIDM75OZi0.jpg',
    'https://imagetmdb.com/t/p/original/8wI0M7HDHhDsoxMCkcAVUx7O6DX.jpg',
    'https://imagetmdb.com/t/p/original/6uLhSLXzB1ooJ3522ydrBZ2Hh0W.jpg',
    'https://imagetmdb.com/t/p/original/veXdzn7LL0bFIDGmE7tTkvRg0qV.jpg',
    'https://imagetmdb.com/t/p/original/lKkkogTlIQT8o83GFQZZ3CA9MzB.jpg',
    'https://imagetmdb.com/t/p/original/ttyRxB2MOkGkhaxdC5d5ElZXaol.jpg',
    'https://imagetmdb.com/t/p/original/hziiv14OpD73u9gAak4XDDfBKa2.jpg',
    'https://imagetmdb.com/t/p/original/ydmZIafp66mHABs3QJDwvjRgZfE.jpg',
    'https://imagetmdb.com/t/p/original/tintsaQ0WLzZsTMkTiqtMB3rfc8.jpg',
    'https://imagetmdb.com/t/p/original/oVD3ClJBoomSQHtnJPAlMfes8YD.jpg',
    'https://imagetmdb.com/t/p/original/vL5LR6WdxWPjLPFRLe133jXWsh5.jpg',
    'https://imagetmdb.com/t/p/original/4f0Kj0QwPui5ydu1UavsnvP1m1o.jpg',
    'https://imagetmdb.com/t/p/original/70AV2Xx5FQYj20labp0EGdbjI6E.jpg',
    ];
    // ];
    // for (var i in _urlImages) {
    //   print(i);
    // }
    // var tmp = await FilmsList().getFilmsList();
    // for (var i in tmp) {
    //   _urlImages.add(i.posterUrl);
    //   print(i.posterUrl);
    //   print(i.id);
    // }

    notifyListeners();

    return true;
  }

}