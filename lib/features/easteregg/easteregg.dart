import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'dart:math';

class EasterEgg extends StatefulWidget {
  const EasterEgg({Key? key}) : super(key: key);

  @override
  State<EasterEgg> createState() => _EasterEggState();
}

class _EasterEggState extends State<EasterEgg> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/easter.mp4')
      ..initialize().then((_) {
        setState(() {}); // Trigger a rebuild once the video is initialized
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    const mainTextColor = Color.fromRGBO(135, 59, 49, 1);

    return Scaffold(
      backgroundColor: Color(0xFFF5F0E1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover, // Choose the fitting option that suits your needs
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
          Center(
            child: ShakingText(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
class ShakingText extends StatefulWidget {
  @override
  _ShakingTextState createState() => _ShakingTextState();
}

class _ShakingTextState extends State<ShakingText> with SingleTickerProviderStateMixin {
  late AnimationController _animcontroller;
  late Animation<double> _animanimation;

  @override
  void initState() {
    super.initState();
    _animcontroller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _animanimation = Tween<double>(begin: -0.03, end: 0.03).animate(_animcontroller)
      ..addListener(() {
        setState(() {});
      });
    _animcontroller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _animanimation.value * pi,
      child: Text(
        "ВЫ НАШЛИ ПАСХАЛКУ))0",
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
