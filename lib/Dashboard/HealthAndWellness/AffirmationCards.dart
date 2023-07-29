import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/Dashboard/HealthAndWellness/Affirmation.dart';
import 'package:SFM/Dashboard/HealthAndWellness/affirmation_data.dart';
import 'package:velocity_x/velocity_x.dart';

class AffirmationCards extends StatelessWidget {
  const AffirmationCards({Key? key}) : super(key: key);
  final String BgImage = 'assets/images/img.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        padding: EdgeInsets.zero,
        title: "Affirmations",
        isAppbar: true,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.screenHeight / 5),
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  children: [
                    afCard(
                      context,
                      title: "Cravings",
                      imagePath: 'assets/images/affirmation/t1.png',
                      affirmations: cravingsAffirmation,
                    ),
                    afCard(
                      context,
                      title: "Self Love",
                      imagePath: 'assets/images/affirmation/t2.png',
                      affirmations: selfLoveAffirmation,
                    ),
                    afCard(
                      context,
                      title: "Well Being",
                      imagePath: 'assets/images/affirmation/t3.png',
                      affirmations: wellBeingAffirmation,
                    ),
                    afCard(
                      context,
                      title: "Relationship",
                      imagePath: 'assets/images/affirmation/t4.png',
                      affirmations: relationshipAffirmation,
                    ),
                    afCard(
                      context,
                      title: "Strength",
                      imagePath: 'assets/images/affirmation/t5.png',
                      affirmations: strengthAffirmation,
                    ),
                    afCard(
                      context,
                      title: "Health",
                      imagePath: 'assets/images/affirmation/t1.png',
                      affirmations: healthAffirmation,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector afCard(BuildContext context,
      {imagePath, title, affirmations}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AffirmationView(
              dataList: affirmations,
              title: title.toString(),
            ));
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.screenWidth / 80),
          width: context.screenWidth / 2.2,
          height: context.screenWidth / 2.2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            // image: DecorationImage(
            //     image: AssetImage(imagePath), fit: BoxFit.cover, opacity: 0.3),
          ),
          child: '$title'
              .text
              .size(25)
              .color(Color(0xff07893B))
              .fontFamily('Kalam')
              .makeCentered()),
    );
  }
}
