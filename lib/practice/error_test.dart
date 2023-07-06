import 'package:flutter/material.dart';

class ErrorTest extends StatelessWidget {
  const ErrorTest({Key? key, this.errorText = "Error"}) : super(key: key);
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorText),
      ),
    );
  }
}
