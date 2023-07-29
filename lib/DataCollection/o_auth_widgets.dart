import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../CommonWidgets/NextButton.dart';

class OAUthWidgets extends StatelessWidget {
  const OAUthWidgets({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    if (false) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NextButton(
              onPressed: onPressed,
              child: Image.asset(
                'assets/images/oauth/g.png',
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(width: 20),
            NextButton(
              child: Image.asset(
                'assets/images/oauth/apple.png',
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(width: 20),
            NextButton(
              child: Image.asset(
                'assets/images/oauth/fb.png',
                height: 25,
                width: 25,
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        width: context.screenWidth / 1.1,
        child: NextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/oauth/g.png',
                  height: 25,
                  width: 25,
                ),
                SizedBox(width: 10),
                Text(
                  "Google",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
