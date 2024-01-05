import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AnimationStar extends StatefulWidget {
  @override
  _AnimationRoomState createState() => _AnimationRoomState();
}

class _AnimationRoomState extends State<AnimationStar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.repeat();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Transform.scale(
        scale: 1.2,
        child: SvgPicture.asset('assets/svg/maskot.svg'),
      ),
    );
  }
}