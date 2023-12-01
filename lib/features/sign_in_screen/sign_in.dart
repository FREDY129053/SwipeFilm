import 'package:mysql1/mysql1.dart';

class sign_in
{
  Future<String> sign_in_check(String login, String password, MySqlConnection conn) async
  {
    await Future.delayed(Duration(microseconds: 10000));
    var log = await conn.query('SELECT login FROM users WHERE login = ?', [login]);
    if (log.toString() != "()")
    {
      var pas = await conn.query('SELECT password FROM users WHERE login = ? AND password = ?', [login, password]);
      if (pas.toString() != "()")
      {
        return "";
      }
      else
      {
        return "Неправильный логин или пароль";
      }
    }
    else
    {
      return "Неправильный логин или пароль";
    }
  }
}