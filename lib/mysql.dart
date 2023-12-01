import 'package:mysql1/mysql1.dart';

class mysql {
  Future<MySqlConnection> connect() async
  {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'password',
        db: 'logreg'
    );
    await Future.delayed(Duration(microseconds: 10000));
    return await MySqlConnection.connect(settings);
  }
}