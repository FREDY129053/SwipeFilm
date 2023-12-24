import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_film/routes/route.dart';

import 'on_changes/card_provider.dart';

class SwipeFilmApp extends StatelessWidget {
  const SwipeFilmApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => CardProvider(),
    child: MaterialApp(
      title: 'Swipe Film',
      debugShowCheckedModeBanner: false,
      routes: routes,
    ),
  );
}