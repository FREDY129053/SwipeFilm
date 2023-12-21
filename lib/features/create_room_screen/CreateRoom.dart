import 'dart:async';

import 'package:mysql1/mysql1.dart';

class DBCreateRoom
{
  Future<void> RoomCommit(int numberOfPeople, int roomType, String password, MySqlConnection conn)
  async {
    await Future.delayed(Duration(microseconds: 1000000));
    conn.query('INSERT rooms (code, count_of_people, theme) VALUES (?, ?, ?);', [password, numberOfPeople, roomType]);
  }
}
