import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentModel extends StatelessWidget {
  PaymentModel({Key? key}) : super(key: key);
  BorderRadius br = const BorderRadius.only(
      topLeft: Radius.circular(30), topRight: Radius.circular(30));

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
      fontSize: context.screenWidth / 20,
      fontWeight: FontWeight.w500,
      color: Color(0xff5F5F5F),
    );
    return Scaffold(
      body: BackgroundContainer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: context.screenHeight / 1.8,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: br),
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Logo
                      SizedBox(
                        height: context.screenWidth / 5,
                        width: context.screenWidth / 5,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      SizedBox(width: 20),

                      /// price content
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Premium', style: ts),
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 4),
                                    Text('₹', style: ts),
                                    Spacer()
                                  ],
                                ),
                                Text('3999',
                                    style: ts.copyWith(
                                      fontSize: context.screenWidth / 11,
                                      color: Color(0xff538A85),
                                    )),
                                Column(
                                  children: [
                                    Spacer(),
                                    Text('/user', style: ts),
                                    SizedBox(height: 4),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: context.screenWidth,
                  child: const Divider(
                    thickness: 1.5,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.done,
                                color: Color(0xff538A85),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'All Mission',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff538A85),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// button
                Container(
                  height: 60,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xff538A85),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: const Text(
                    "Unlock All features",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
