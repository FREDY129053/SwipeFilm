import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipe_film/repo/models/FilmInfo.dart';

import '../mysql.dart';

class FilmsList {
  Set<FilmInfo> resultFilms = <FilmInfo>{};
  final Dio dio = Dio();
  String apiKey = 'DN35CZS-9REMWPS-MFN7N0P-2Z7ZGCB';

  Future<List<FilmInfo>> getFilmsList(int roomID, int theme) async {
    Set<FilmInfo> resultFilms = <FilmInfo>{};

    var conn = await mysql().connect();
    await Future.delayed(const Duration(microseconds: 1000000));
    var res = (await conn.query('''
        SELECT members.user_id, g.genre 
        FROM genres g
        JOIN user_choice_genre user_choice ON g.id = user_choice.genre_id
        JOIN particians_of_rooms members ON user_choice.member_id = members.user_id
        WHERE members.room_id = ?
    ''', [roomID]));

    Set<int> countMembers = {};
    Map<int, List<String>> genresByUser = {};
    for (var row in res) {
      int userId = row[0];
      countMembers.add(userId);
      String genre = row[1].toString();
      if (!genresByUser.containsKey(userId)) {
        genresByUser[userId] = [];
      }

      genresByUser[userId]?.add(genre);
    }

    List<List<String>> genres = genresByUser.values.toList();
    print("ALL GENRES = $genres");
    List<String> sameGenres = List.from(genres.first);
    for (var i = 1; i < genres.length; i++) {
      sameGenres =
          sameGenres.where((genre) => genres[i].contains(genre)).toList();
    }
    for (var i = 0; i < genres.length; i++) {
      genres[i].removeWhere((element) => sameGenres.contains(element));
    }

    List<List<String>> allGenres = [];
    List<List<String>> newGenres = genres.map((list) => list.toList()).toList();
    allGenres.add(sameGenres);
    // Перестановки жанров у пользователей
    for (var i = 0; i < newGenres.length - 1; i++) {
      newGenres[i].removeWhere((element) => sameGenres.contains(element));
      if (newGenres[i].isEmpty) continue;
      for (var j = i + 1; j < newGenres.length; j++) {
        newGenres[j].removeWhere((element) => sameGenres.contains(element));
        if (newGenres[j].isEmpty) continue;
        allGenres.addAll(newGenres[i].expand((first) =>
            newGenres[j].map((second) => [first, second])).toList());
      }
    }


    int filmCount = 60;

    if (allGenres[0].isEmpty) {   // Если нет общих жанров
      var tmp = [];
      for (var i in allGenres) {
        if (i.isNotEmpty) {
          tmp.add(i);
        }
      }
      int n = filmCount ~/ (allGenres.length - 1) + 1;
      n++;
      for (int i = 0; i < tmp.length; i++) {
        // Запрос к API по всем парам жанров
        final response = await dio.get(
            _getUrl(n, tmp[i], theme),
            options: Options(
              headers: {'X-API-KEY': apiKey},
            )
        );

        // Получение данных из API
        final data = response.data as Map<String, dynamic>;
        final apiResult = data['docs'];

        // Формирование данных для класса FilmInfo
        for (var i in apiResult) {
          int id = i['id'];
          String name = i['name'] ?? i['names'][0][0];
          String country = List<String>.from(
              i['countries'].map((genre) => genre['name'] as String))[0];
          String poster = i['backdrop']['url'];
          int year = i['year'];
          String desc = i['shortDescription'] ?? '\nНет описания\n';
          var genres = List<String>.from(
              i['genres'].map((genre) => genre['name'] as String));
          int movieLength = i['movieLength'];
          FilmInfo fl = FilmInfo(
              id: id,
              name: name,
              country: country,
              posterUrl: poster,
              year: year,
              description: desc,
              genres: genres,
              duration: movieLength
          );

          resultFilms.add(fl);
          // print(fl.name);
        }
      }
    } else {
      List<List<String>> tmp;
      int countOfSamePairsGenres;
      // Формируем новый массив с нужными жанрами и узнаем сколько пар общих жанров
      if (allGenres[0].length == 1) { // Если один общий жанр то мы приводим к масисву из 1 жанра общего и пустого элемента
        tmp = allGenres;
        tmp[0] = [tmp[0][0], tmp[0][0]];
        countOfSamePairsGenres = 1;
      } else if (allGenres[0].length == 2) {  // Если два общих жанра то норм
        tmp = allGenres;
        countOfSamePairsGenres = 1;
      } else {  // Если 3 и более общих жанров то рекурсивно создаем уникальные перестановки
        int lengthBeforePairs = allGenres.length;
        tmp = [];
        _createUniquePairs(allGenres[0], 0, [], tmp);
        allGenres.removeAt(0);
        tmp.addAll(allGenres);
        countOfSamePairsGenres = tmp.length - lengthBeforePairs;
      }

      for (int i = 0; i < tmp.length; i++) {
        int n = filmCount;
        // Если одна общая пара, то 70% генерируемых фильмов будет с этой парой жанров
        if (countOfSamePairsGenres == 1) {
          if (i == 0) {
            n = ((filmCount / 100) * 70).toInt();
            filmCount -= n;
          } else {
            n = filmCount ~/ tmp.sublist(1).length + 1;
          }
        }
        // Если несколько общих пар, то 70% фильмов делятся на кол-во этих пар, чтобы генерировало m фильмо из 70% для пар
        else if (countOfSamePairsGenres > 1) {
          if (i != countOfSamePairsGenres - 1) {
            n = ((filmCount / 100) * 70) ~/ countOfSamePairsGenres;
            filmCount -= (n * countOfSamePairsGenres);
          } else {
            n = filmCount ~/ tmp.sublist(countOfSamePairsGenres - 1).length;
          }
        }
        n++;
        print("I = ${tmp[i]} and N = $n");
        // Запрос к API по всем парам жанров
        final response = await dio.get(
            _getUrl(n, tmp[i], theme),
            options: Options(
              headers: {'X-API-KEY': apiKey},
            )
        );

        // Получение данных из API
        final data = response.data as Map<String, dynamic>;
        final apiResult = data['docs'];

        // Формирование данных для класса FilmInfo
        for (var i in apiResult) {
          int id = i['id'];
          String name = i['name'] ?? i['names'][0][0];
          String country = List<String>.from(
              i['countries'].map((genre) => genre['name'] as String))[0];
          String poster = i['backdrop']['url'];
          int year = i['year'];
          String desc = i['shortDescription'] ?? '\nНет описания\n';
          var genres = List<String>.from(
              i['genres'].map((genre) => genre['name'] as String));
          print("ID = $id");
          int movieLength = i['movieLength'] != null ? i['movieLength'] :  999999;
          FilmInfo fl = FilmInfo(
              id: id,
              name: name,
              country: country,
              posterUrl: poster,
              year: year,
              description: desc,
              genres: genres,
              duration: movieLength
          );

          resultFilms.add(fl);
          print(fl.name);
        }
      }
    }

    return resultFilms.toList();
  }

  String _getUrl(int count, List<String> pairGenre, int theme) {
    int n = count;
    if (theme == 2)
      {
        return 'https://api.kinopoisk.dev/v1.4/movie?limit=$n'
            '&selectFields=id'
            '&selectFields=name'
            '&selectFields=names'
            '&selectFields=year'
            '&selectFields=countries'
            '&selectFields=shortDescription'
            '&selectFields=movieLength'
            '&selectFields=backdrop'
            '&selectFields=genres'
            '&genres.name=%2B${pairGenre[0]}'
            '&genres.name=%2B${pairGenre[1]}'
            '&genres.name=аниме'
            '&type=anime'
            '&type=%21tv-series'
            '&type=%21cartoon'
            '&type=%21animated-series'
            '&type=%21movie';
      } else {
        return 'https://api.kinopoisk.dev/v1.4/movie?limit=$n'
            '&selectFields=id'
            '&selectFields=name'
            '&selectFields=names'
            '&selectFields=year'
            '&selectFields=countries'
            '&selectFields=shortDescription'
            '&selectFields=movieLength'
            '&selectFields=backdrop'
            '&selectFields=genres'
            '&genres.name=%2B${pairGenre[0]}'
            '&genres.name=%2B${pairGenre[1]}'
            '&genres.name=%21мультфильм'
            '&genres.name=%21аниме'
            '&type=%21tv-series'
            '&type=%21anime'
            '&type=%21cartoon'
            '&type=%21animated-series'
            '&type=movie';
    }
  }

  void _createUniquePairs(List<String> items, int start, List<String> pair, List<List<String>> result) {
    if (pair.length == 2) {
      result.add(List.from(pair));
      return;
    }

    for (int i = start; i < items.length; i++) {
      pair.add(items[i]);
      _createUniquePairs(items, i + 1, pair, result);
      pair.removeLast();
    }
  }
}