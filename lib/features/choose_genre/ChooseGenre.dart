import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';
import 'package:swipe_film/mysql.dart';
import 'package:swipe_film/features/choose_genre/choose_genre.dart';

class Genre
{
  String name = "";
  int id = 0;

  Genre(String genreName, int genreId)
  {
    name = genreName;
    id = genreId;
  }
}

class DBChooseGenre
{
  Future<List<Genre>> GetGenres(MySqlConnection conn)
  async
  {
    await Future.delayed(Duration(microseconds: 500000));
    var queryNames = await conn.query("SELECT genre FROM genres");
    await Future.delayed(Duration(microseconds: 500000));
    var queryIds = await conn.query("SELECT id FROM genres");
    List<Genre> genres = [];
    for (int i = 0; i < queryNames.length; i++)
      {
        String strName = queryNames.elementAt(i).toString();
        int endName = queryNames.elementAt(i).toString().length - 1;
        String strId = queryIds.elementAt(i).toString();
        int endId = queryIds.elementAt(i).toString().length - 1;
        Genre genre = Genre(strName.substring(16, endName), int.parse(strId.substring(13, endId)));
        genres.add(genre);
      }
    conn.close();
    return genres;
  }

  Future<void> GenresCommit(Set<int> ids, int id) async {
    try {
      var conn = await mysql().connect();
      List<int> idsList = ids.toList();
      print("List = $idsList");
      for (int i = 0; i < idsList.length; i++) {
        await Future.delayed(const Duration(microseconds: 10));
        await conn.query('INSERT INTO user_choice_genre (member_id, genre_id) VALUES (?, ?)', [id, idsList[i]]);
        print("Inserted: $id, ${idsList[i]}");
      }
    } catch (e) {
      print("Error $e");
    }
  }
}