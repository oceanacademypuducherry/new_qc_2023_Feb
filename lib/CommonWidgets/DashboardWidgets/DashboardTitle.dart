import 'package:flutter/material.dart';

class DashboardTitle extends StatelessWidget {
  DashboardTitle({Key? key, this.title = "Title"}) : super(key: key);

  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            color: Color(0xff72919E),
            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat"),
      ),
    );
  }
}
