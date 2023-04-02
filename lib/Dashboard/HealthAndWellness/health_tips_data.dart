import 'package:flutter/material.dart';

final List<HealthTipsData> category = [
  HealthTipsData(
      src: 'assets/images/health_tips/water.png',
      title: "Water",
      color: const Color(0xff00DEFE),
      tips: [
        "Helps with hydration: Water is essential for maintaining good hydration levels in the body. When the body is dehydrated, it can lead to fatigue, dizziness, headaches, and other health problems. Drinking enough water helps to prevent these issues and keeps the body functioning properly.",
        "Aids in digestion: Drinking water before and after meals can help with digestion. Water helps to break down food and move it through the digestive tract. This can help to prevent constipation and other digestive problems.",
        "Supports healthy skin: Water is important for maintaining healthy skin. It helps to keep the skin hydrated and can improve its overall appearance. Drinking enough water can also help to reduce the appearance of wrinkles and fine lines.",
        "Helps to regulate body temperature: Water helps to regulate body temperature by carrying heat away from the body when we sweat. This is important for preventing heat stroke and other heat-related illnesses.",
      ]),
  HealthTipsData(
      src: 'assets/images/health_tips/vitamin.png',
      title: "Vitamins",
      color: const Color(0xffFF7F00),
      tips: [
        "Vitamin C: Smoking can deplete the body of vitamin C, which is important for immune function and wound healing. Increasing your intake of vitamin C can help reduce some of the negative effects of smoking on the body. Foods that are high in vitamin C include citrus fruits, berries, kiwi, mango, papaya, broccoli, Brussels sprouts, and bell peppers.",
        "Vitamin E: Smoking can also reduce the levels of vitamin E in the body, which is an antioxidant that helps to protect cells from damage. Foods that are high in vitamin E include almonds, sunflower seeds, spinach, avocado, and sweet potato.",
        "B vitamins: B vitamins are important for energy production and can help to reduce some of the fatigue and depression that may be experienced when quitting smoking. Foods that are high in B vitamins include whole grains, leafy green vegetables, dairy products, meat, and fish.",
        "Multivitamin supplement: Taking a daily multivitamin supplement can help ensure that you are getting all of the vitamins and minerals that your body needs during the quitting process. It's important to choose a high-quality supplement that contains a balanced blend of vitamins and minerals, and to consult with a healthcare professional before starting any supplement regimen.",
      ]),
  HealthTipsData(
      src: 'assets/images/health_tips/meat.png',
      title: "Protein",
      color: const Color(0xffB71319),
      tips: [
        "Helps with cravings: Protein-rich foods can help to reduce cravings for cigarettes by providing a steady source of energy and reducing blood sugar fluctuations. This can be particularly helpful during the first few days or weeks after quitting when cravings may be strongest.",
        "Supports mood and energy levels: Nicotine withdrawal can cause fatigue, mood swings, and other emotional symptoms. Eating protein-rich foods can help to maintain steady blood sugar levels and support the production of neurotransmitters that regulate mood, such as dopamine and serotonin.",
        "Promotes cell repair: Smoking can cause damage to the body's tissues, and quitting smoking can trigger a healing process. Protein is essential for repairing and rebuilding damaged tissues and can support the body's repair process.",
        "Supports overall health: Quitting smoking can improve overall health, and consuming protein-rich foods can support the body's recovery and improve overall health outcomes. Eating a balanced diet that includes protein can help to reduce the risk of chronic diseases such as heart disease, diabetes, and certain cancers.",
      ]),
  HealthTipsData(
      src: 'assets/images/health_tips/orange.png',
      title: "Juice",
      color: const Color(0xffFF7F00),
      tips: [
        "Citrus juice: Citrus fruits are rich in vitamin C, which can help to reduce some of the negative effects of smoking on the body. Drinking citrus juices such as orange or grapefruit juice can help to replenish vitamin C levels and support immune function.",
        "Vegetable juice: Vegetable juices are a great way to consume a variety of nutrients in one go, which can support overall health and help to reduce the risk of chronic diseases. Consuming vegetable juice can also help to reduce inflammation in the body, which can be beneficial during the healing process after quitting smoking.",
        "Herbal tea: Herbal teas such as chamomile, peppermint, or ginger can help to reduce stress and anxiety, which can be helpful when dealing with the emotional symptoms that may arise during the quitting process.",
        "Green juice: Green juices are a great source of antioxidants, vitamins, and minerals that can support overall health and reduce inflammation in the body. Green juice can also help to support energy levels and reduce fatigue during the quitting process."
      ]),
  HealthTipsData(
      src: 'assets/images/health_tips/nrt.png',
      title: "NRT",
      color: const Color(0xffD9B279),
      tips: [
        "Reduces withdrawal symptoms: NRT can help to reduce the severity of nicotine withdrawal symptoms such as irritability, anxiety, and cravings. This can make it easier to quit smoking and can improve your chances of success.",
        "Gradual nicotine reduction: NRT products such as nicotine gum, patches, lozenges, or inhalers can provide a steady and controlled dose of nicotine, which can help to gradually reduce the amount of nicotine in the body. This can make the transition to a nicotine-free life easier and less overwhelming.",
        "Customizable dosages: NRT products are available in a range of dosages and forms, which can be tailored to suit your individual needs and preferences. This can help to maximize the effectiveness of NRT and increase your chances of success.",
        "Lowers health risks: Smoking is a leading cause of preventable death and is associated with numerous health risks, including heart disease, stroke, and lung cancer. Quitting smoking, even with the help of NRT, can significantly lower these risks and improve overall health outcomes.",
      ]),
];

class HealthTipsData {
  HealthTipsData(
      {this.src = "",
      this.title = "",
      this.color = Colors.grey,
      this.tips = const []});

  String src;
  String title;
  Color color;
  final List<String> tips;
}
