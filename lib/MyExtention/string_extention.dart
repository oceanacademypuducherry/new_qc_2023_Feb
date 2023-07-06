extension MyStringExtension on String {
  String toTitleCase() {
    String output = "";
    if (isEmpty) {
      return "";
    }
    for (String i in split(' ')) {
      i = i.trim();
      if (i.isEmpty) continue;
      output += "${i[0].toUpperCase()}${i.substring(1)} ";
    }

    return output;
  }
}
