class DateTimeFormatter {
  static String formatDateTime(String hour, String minute, String date) {
    if (date == "e") {
      return "e $hour:$minute:00";
    } else {
      return "$date $hour:$minute:00";
    }
  }

  static List<String> extractDateTime(String formattedString) {
    List<String> parts = formattedString.split(" ");

    if (parts.length == 2) {
      String dateOrE = parts[0];
      String time = parts[1];

      List<String> timeParts = time.split(":");
      if (timeParts.length == 3) {
        String hour = timeParts[0];
        String minute = timeParts[1];

        if (dateOrE == "e") {
          return ["e", hour, minute];
        } else {
          return [dateOrE, hour, minute];
        }
      }
    }
    // If the formatted string is not in the expected format, return an empty list.
    return [];
  }
}
