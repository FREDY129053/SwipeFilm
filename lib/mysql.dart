import 'package:mysql1/mysql1.dart';
import 'package:swipe_film/config.dart';
export 'config.dart';

class mysql {
  Future<MySqlConnection> connect() async
  {
    var settings = new ConnectionSettings(
        host: dbHost,
        port: dbPort,
        user: dbUser,
        password: dbPassword,
        db: dbName
    );
    await Future.delayed(Duration(microseconds: 10000));
    return await MySqlConnection.connect(settings);
  }
}