import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        isAppbar: true,
        title: "Feedback",
        isBackButton: true,
        child: Center(
          child: Text('Feedback'),
        ),
      ),
    );
  }
}
