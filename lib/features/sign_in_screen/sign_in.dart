import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:mysql1/mysql1.dart';

class DBSignIn
{
  Future<String> SignInCheck(String login, String password, MySqlConnection conn) async
  {
    await Future.delayed(Duration(microseconds: 1000000));
    var log = await conn.query('SELECT login FROM users WHERE login = ?', [login]);
    if (log.toString() != "()")
    {
      var bytes = utf8.encode(password);
      var pas = await conn.query('SELECT password FROM users WHERE login = ? AND password = ?', [login, sha1.convert(bytes).toString()]);
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

  Future<int> GetUserId(String login, MySqlConnection conn) async
  {
    await Future.delayed(Duration(microseconds: 1000000));
    var id = await conn.query('SELECT id FROM users WHERE login = ?', [login]);
    return int.parse(id.elementAt(0).toString().substring(13, id.elementAt(0).toString().length - 1));
  }
}