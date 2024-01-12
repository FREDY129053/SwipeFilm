import 'package:flutter_test/flutter_test.dart';
import 'package:swipe_film/features/sign_in_screen/sign_in.dart';
import 'package:swipe_film/features/sign_up_screen/sign_up.dart';
import 'package:swipe_film/mysql.dart';

void main() {
  test("Логин занят", () async {
    var conn = await mysql().connect();
    expect(await DBSignUp().SignUpCheck("а", "rsfdsfdsfd", "rsfdsfdsfd", conn), "Логин уже занят");
  });

  test("Пустые данные", () async {
    var conn = await mysql().connect();
    expect(await DBSignUp().SignUpCheck("", "", "", conn), "Придумайте логин и пароль");
  });

  test("Разные пароли", () async {
    var conn = await mysql().connect();
    expect(await DBSignUp().SignUpCheck("аыва", "fsdsdf", "uytr", conn), "Пароли не совпадают");
  });

  test("Успешная регистрация", () async {
    var conn = await mysql().connect();
    expect(await DBSignUp().SignUpCheck("dfs6534jfds4", "46578", "46578", conn), "");
  });

  test("Логин занят и пароли не совпадают", () async {
    var conn = await mysql().connect();
    expect(await DBSignUp().SignUpCheck("а", "46578", "544", conn), "Логин уже занят");
  });

  test("Успешный вход", () async {
    var conn = await mysql().connect();
    expect(await DBSignIn().SignInCheck("а", "а", conn), "");
  });

  test("Неверный пароль", () async {
    var conn = await mysql().connect();
    expect(await DBSignIn().SignInCheck("а", "543павапав", conn), "Неправильный логин или пароль");
  });

  test("Неверный логин", () async {
    var conn = await mysql().connect();
    expect(await DBSignIn().SignInCheck("а54332", "а", conn), "Неправильный логин или пароль");
  });
}