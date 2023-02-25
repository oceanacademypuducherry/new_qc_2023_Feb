import 'package:flutter/material.dart';

class ImageTest extends StatelessWidget {
  ImageTest({Key? key, required this.image}) : super(key: key);
  Image image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.green,
      child: Center(
        child: image,
      ),
    ));
  }
}
