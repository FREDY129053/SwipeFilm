import 'package:mysql1/mysql1.dart';

class DBEnterRoom
{
  Future<String> EnterRoom(String id, String password, MySqlConnection conn)
  async {
    await Future.delayed(Duration(microseconds: 500000));
    var roomCheck = await conn.query('SELECT is_start FROM rooms WHERE id = ? AND code = ?', [id, password]);
    if (roomCheck.toString() != "()")
    {
      String isStart = roomCheck.toString().substring(20, 21);
      if (isStart == "0")
        {
          await Future.delayed(Duration(microseconds: 500000));
          var countOfPeople = await conn.query('SELECT count_of_people FROM rooms WHERE id = ? AND code = ?', [id, password]);
          await Future.delayed(Duration(microseconds: 500000));
          var currCountOfPeople = await conn.query('SELECT * FROM particians_of_rooms WHERE room_id = ?', [id]);
          int peopleCount = int.parse(countOfPeople.toString().substring(27, 28));
          if (peopleCount != currCountOfPeople.length)
            {
              return "";
            }
          else
            {
              return "Комната уже заполнена";
            }
        }
      else
        {
          return "Сессия уже начата";
        }
    }
    else
    {
      return "Неправильный ID комнаты или пароль";
    }
  }
}
