import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class Screenshotshare extends StatelessWidget {
  Screenshotshare({Key? key}) : super(key: key);
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Screenshot(
            controller: _screenshotController,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
          ),
          TextButton(
              onPressed: () async {
                dynamic byte =
                    await _screenshotController.capture().then((image) async {
                  if (image != null) {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        await File('${directory.path}/image.png').create();
                    await imagePath.writeAsBytes(image);
                    Share.shareXFiles([
                      XFile.fromData(
                        image,
                        path: imagePath.path,
                      ),
                    ], text: "Testing");
                  }
                });
              },
              child: Text("take shot")),
        ],
      ),
    );
  }
}
