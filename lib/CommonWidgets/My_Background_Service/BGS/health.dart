class Health {
  final String title;
  final int calculationTime;
  final int totalMinutesOrDays;
  final String description;
  final String timing;
  Health(
      {required this.title,
      required this.calculationTime,
      required this.totalMinutesOrDays,
      required this.description,
      required this.timing});
  bool get isFinish => calculationTime < totalMinutesOrDays;
  int get isNotifyAt => calculationTime - totalMinutesOrDays;

  // factory Health.fromJson(Map<String, dynamic> data) {
  //   return Health(data['title'], data['calculationTime'],
  //       data['totalMinutesOrDays'], data['description'], data['timing']);
  // }
}

List<Health> addHealthImprovements(int totalSeconds) {
  int totalMinutes = totalSeconds ~/ 60;
  int totalHours = totalMinutes ~/ 60;
  int totalDays = totalHours ~/ 24;

  List<Health> healthData = [
    Health(
      title: 'Pules Rate',
      calculationTime: 20,
      totalMinutesOrDays: totalMinutes,
      description: '20 Minutes',
      timing: 'minutes',
    ),
    Health(
      title: 'Oxygen Level',
      calculationTime: 480,
      totalMinutesOrDays: totalMinutes,
      description: '8 Hours',
      timing: 'minutes',
    ),
    Health(
      title: 'Carbon monoxide level',
      calculationTime: 1440,
      totalMinutesOrDays: totalMinutes,
      description: '24 Hours',
      timing: 'minutes',
    ),
    Health(
      title: 'Nicotine expelled from body',
      calculationTime: 2520,
      totalMinutesOrDays: totalMinutes,
      description: '42 Hours',
      timing: 'minutes',
    ),
    Health(
      title: 'Taste and smell',
      calculationTime: 14400,
      totalMinutesOrDays: totalMinutes,
      description: '10 Days',
      timing: 'minutes',
    ),
    Health(
      title: 'Taste and smell',
      calculationTime: 14400,
      totalMinutesOrDays: totalMinutes,
      description: '10 Days',
      timing: 'minutes',
    ),
    Health(
      title: 'Breathing',
      calculationTime: 120960,
      totalMinutesOrDays: totalMinutes,
      description: '12 Weeks',
      timing: 'minutes',
    ),
    Health(
      title: 'Energy levels',
      calculationTime: 273,
      totalMinutesOrDays: totalDays,
      description: '9 Months',
      timing: "day",
    ),
    Health(
      title: 'Bed Breath',
      calculationTime: 1825,
      totalMinutesOrDays: totalDays,
      description: '5 Years',
      timing: "day",
    ),
    Health(
      title: 'Tooth Stationing',
      calculationTime: 365,
      totalMinutesOrDays: totalDays,
      description: '1 Years',
      timing: "day",
    ),
    Health(
      title: 'Cums and Teeth',
      calculationTime: 3650,
      totalMinutesOrDays: totalDays,
      description: '10 Years',
      timing: "day",
    ),
    Health(
      title: 'Circulation',
      calculationTime: 5475,
      totalMinutesOrDays: totalDays,
      description: '15 Years',
      timing: "day",
    ),
    Health(
      title: 'Gum texture',
      calculationTime: 7300,
      totalMinutesOrDays: totalDays,
      description: '20 Years',
      timing: "day",
    ),
  ];
  return healthData;
}
