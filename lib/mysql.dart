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
}