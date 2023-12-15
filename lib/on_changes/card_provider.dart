import 'package:flutter/cupertino.dart';

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

  void test() {
    _urlImages = <String>[
      'assets/images/homealone.png',
      'assets/images/mew.png',
      'assets/images/homealone.png',
      'assets/images/mew.png',
      'assets/images/homealone.png',
      'assets/images/mew.png',
    ].reversed.toList();

    notifyListeners();
  }
}