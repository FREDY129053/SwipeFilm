import 'package:flutter/material.dart';
import 'package:swipe_film/routes/route.dart';

class SwipeFilmApp extends StatelessWidget {
  const SwipeFilmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}