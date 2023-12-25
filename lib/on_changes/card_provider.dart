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

  Future<void> test() async {
    _urlImages = <String>[
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/4c36aebf-9fb1-47cf-b1d5-90e916d0314b/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/ccd69a69-7405-4b41-89a8-60dd6dc2a3ee/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/3560b757-9b95-45ec-af8c-623972370f9d/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/96d93e3a-fdbf-4b6f-b02d-2fc9c2648a18/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/6fc34eac-75c9-4a89-8740-611ec978159c/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/f94e36eb-2a77-422b-94f2-c599c418497c/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/ea280ff7-1989-44e4-97a8-e2598aa951a4/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1629390/9e9e2b2c-a3c1-462e-8d84-e6a19fbe5b9c/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/d5ee73ae-82af-4f60-af5e-f080bed523d8/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/db4fbef1-466a-4dec-9b7a-d4f13eb45738/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/907e3552-9a1e-48d1-8a01-d013a76a8343/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/fd4e75bb-a6fe-46ef-86cd-0f470334fcbd/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/02d70d58-ae4e-4ef4-b886-c215e9e99436/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/ed4f90cb-188b-4cac-a41a-c175ff9b9e48/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/80f21137-eebb-4cdc-8124-96c68c07c2a8/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/5b0441e5-a7d8-4504-bbdc-2ff05852e538/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/0bb13a61-cfbe-4c76-b72e-f799bc9b7d79/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/6cd71c8d-c906-4430-83a2-60f31c345954/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/e16bb488-b57a-45f4-8566-615a58d8008f/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/390dc48d-2025-4323-b225-cb0883ab8374/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/185b0c9f-d07a-4529-b023-cdb20eceb18a/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1629390/82f8a2dc-a439-4832-9f0f-dc599e6e78d2/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/946e69f2-80eb-41c1-b1cd-695a4644be55/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/022a58e3-5b9b-411b-bfb3-09fedb700401/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/244e2847-f426-4c60-86ba-34cde7db695f/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/a8f24236-a088-4858-a9b3-00e8db58bd00/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/e34456ea-9e9f-4fb7-b03c-4146f96f7fd5/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1898899/27ed5c19-a045-49dd-8624-5f629c5d96e0/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1898899/211e880d-c183-43aa-83b0-13c08109eaf7/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/637271d5-61b4-4e46-ac83-6d07494c7645/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1898899/83100637-9876-4ec7-8cdc-4efa581657ec/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/4adf61aa-3cb7-4381-9245-523971e5b4c8/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/a2da53fd-24c9-4715-8f98-5382b387fd4d/orig',
    'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/90d57813-387c-44c4-81c1-ecddb3c417a5/orig',
    ];
    for (var i in _urlImages) {
      print(i);
    }
    // var tmp = await FilmsList().getFilmsList();
    // for (var i in tmp) {
    //   _urlImages.add(i.posterUrl);
    //   print(i.posterUrl);
    // }

    notifyListeners();
  }
}