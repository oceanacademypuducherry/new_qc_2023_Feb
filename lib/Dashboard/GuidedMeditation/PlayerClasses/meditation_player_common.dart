import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MeditationDisplay extends StatelessWidget {
  MeditationDisplay({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: s.height / 2.8,
          width: s.height / 2.8,
          padding: EdgeInsets.symmetric(horizontal: context.screenHeight / 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white30,
          ),
          child: Image(image: AssetImage('assets/images/logo.png')),
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: 0.5,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: s.width / 15,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
