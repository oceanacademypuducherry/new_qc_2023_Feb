import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:velocity_x/velocity_x.dart';

class JournalRead extends StatelessWidget {
  JournalRead({Key? key}) : super(key: key);
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(data);
    TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.bold, color: Vx.gray700);
    double width = context.screenWidth - 25;
    EdgeInsets margin = EdgeInsets.symmetric(vertical: 10);
    Color bgColor = Colors.white.withOpacity(0.4);
    // bgColor = Colors.white;
    return Scaffold(
      body: BackgroundContainer(
        isAppbar: true,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                width: width,
                margin: margin,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['isMorning']
                          ? 'I am grateful for'
                          : "How did I do with uplifting someone and improving the environment today?",
                      style: titleStyle,
                    ),
                    SizedBox(height: 10),
                    Text(data['title1']),
                  ],
                ),
              ),
              Container(
                width: width,
                margin: margin,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['isMorning']
                          ? 'Who  will I uplift today and how will i do so?'
                          : "What lessons did I learn today and how will I apply this in the future?",
                      style: titleStyle,
                    ),
                    SizedBox(height: 10),
                    Text(data['title2']),
                  ],
                ),
              ),
              Container(
                width: width,
                margin: margin,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['isMorning']
                          ? 'How can i improve the environment today?'
                          : "Today\'s reflections...",
                      style: titleStyle,
                    ),
                    SizedBox(height: 10),
                    Text(data['title3']),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                    width: width,
                    child: Image.asset('assets/images/journal_vector.png')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
