import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);
    return MaterialApp(
      title: 'Flutter Demo',
      // Темы нужны для того, чтобы не менять у каждого объекта стиль, а задать паре объектов
      // одну тему, поменять в теме атрибут и увидеть результат везде
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFE76838)),
            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
          ),
        ),
        useMaterial3: true,
        // Темы текста
        textTheme: const TextTheme(
          // Тема для больших заголовков
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 32,
            color: mainTextColor,
          ),
          // Тема для подписей
          bodySmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: mainTextColor,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/svg/app_logo.svg'),

            Text(
              'Войти',
              style: GoogleFonts.raleway(textStyle: theme.textTheme.bodyLarge),
            ),

            Text(
              'Войдите в свой аккаунт, чтобы пользоваться приложением',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(textStyle: theme.textTheme.bodySmall),
            ),

            const SizedBox(
              width: 345,
              height: 56,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите свой email',
                  alignLabelWithHint: true,
                ),
              ),
            ),

            const SizedBox(
              width: 345,
              height: 56,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите пароль',
                ),
              ),
            ),

            SizedBox(
              width: 345,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Войти')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

