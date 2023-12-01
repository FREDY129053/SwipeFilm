import 'dart:ffi';

import 'package:mysql1/mysql1.dart';
import 'package:swipe_film/mysql.dart';
import 'dart:async';

class sign_up
{
  Future<void> user_commit(String login, String password, MySqlConnection conn)
  async {
    await Future.delayed(Duration(microseconds: 10000));
    conn.query('INSERT users (login, password) VALUES (?, ?);', [login, password]);
  }

  Future<String> login_check(String login, MySqlConnection conn)
  async {
    await Future.delayed(Duration(microseconds: 10000));
    var results = await conn.query('SELECT login FROM users WHERE login = ?', [login]);
    return results.toString();
  }

  Future<String> sign_up_check(String login, String password, String passwordRepeat, MySqlConnection conn)
  async {
    if (login == "" || password == "" || passwordRepeat == "")
    {
      return "Придумайте логин и пароль";
    }
    else if (await sign_up().login_check(login, conn) != "()")
    {
      return "Логин уже занят";
    }
    else if (password != passwordRepeat)
    {
      return "Пароли не совпадают";
    }
    else
    {
      return "";
    }
  }
}