import 'package:mysql1/mysql1.dart';

class DBEnterRoom
{
  Future<String> EnterRoom(String id, String password, MySqlConnection conn)
  async {
    await Future.delayed(Duration(microseconds: 1000000));
    var roomCheck = await conn.query('SELECT id FROM rooms WHERE id = ? AND code = ?', [id, password]);
    if (roomCheck.toString() != "()")
    {
      return "";
    }
    else
    {
      return "Неправильный ID комнаты или пароль";
    }
  }
}
