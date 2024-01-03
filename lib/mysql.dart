import 'package:mysql1/mysql1.dart';
import 'package:swipe_film/config.dart';
export 'config.dart';

class mysql {
  Future<MySqlConnection> connect() async
  {
    var settings = ConnectionSettings(
        host: dbHost,
        port: dbPort,
        user: dbUser,
        password: dbPassword,
        db: dbName
    );
    await Future.delayed(const Duration(microseconds: 10000));
    return await MySqlConnection.connect(settings);
  }

  // Удаление комнаты с ее участниками и выбранными жанрами
  Future<void> DeleteRoom(MySqlConnection conn, int roomId)
  async {
    await Future.delayed(const Duration(microseconds: 500000));
    var queryParticians = await conn.query('SELECT user_id FROM particians_of_rooms WHERE room_id = ?', [roomId]);
    for (int i = 0; i < queryParticians.length; i++)
    {
      String strUserId = queryParticians.elementAt(i).toString();
      int endUserId = queryParticians.elementAt(i).toString().length - 1;
      int userId = int.parse(strUserId.substring(18, endUserId));
      await conn.query('DELETE FROM user_choice_genre WHERE member_id = ?', [userId]);
    }
    await conn.query('DELETE FROM particians_of_rooms WHERE room_id = ?', [roomId]);
    await conn.query('DELETE FROM rooms WHERE id = ?', [roomId]);
  }

  // Удаление участника
  Future<void> DeletePartician(MySqlConnection conn, int userId)
  async {
    await Future.delayed(const Duration(microseconds: 500000));
    await conn.query('DELETE FROM user_choice_genre WHERE member_id = ?', [userId]);
    await conn.query('DELETE FROM particians_of_rooms WHERE user_id = ?', [userId]);
  }
}