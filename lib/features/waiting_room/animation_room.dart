import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimationRoom extends StatefulWidget {
  @override
  _AnimationRoomState createState() => _AnimationRoomState();
}

class _AnimationRoomState extends State<AnimationRoom> with SingleTickerProviderStateMixin
 {
   late AnimationController _controller;
   late Animation<double> _animation;

   @override
   void initState() {
     super.initState();
     _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));

     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

     _controller.repeat();
   }

   void dispose() {
     _controller.dispose();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(
             child: RotationTransition(
               turns: _animation,
               child: Transform.scale(
                 scale: 1.2,
                 child: SvgPicture.asset('assets/svg/maskot.svg'),
               ),
             ),
           )
         ],
       ),
     );
   }
 }


