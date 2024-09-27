import 'package:flutter/foundation.dart';

class Utility {

  static String getTime(String dateTime) {
    String hour = dateTime.substring(11, 13);
    String minute = dateTime.substring(13, 16);

    String time12Hr = "";

    if (double.parse(hour) < 12) {
      if (kDebugMode) {
        print("$hour${minute}am");
      }
      time12Hr = "$hour${minute}am";
    } else {
      // print("${double.parse(hour).toInt() - 12}${dateTime.substring(13, 16)}pm");
      time12Hr = "${double.parse(hour).toInt() - 12}${minute}pm";
    }

    return time12Hr;
  }

  static String getDate(String dateTime) {
    String date = dateTime.substring(8, 10);
    return date;
  }

  static String getMonthName(String dateTime) {
    String month = dateTime.substring(5, 7);
    switch (double.parse(month)) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }

    return month;
  }

  static String getYear(String dateTime) {
    String year = dateTime.substring(0, 4);
    return year;
  }

  // my formatted date wanted = 7:30pm Jan 1 2024
  static String getMyFormattedDateTime(String dateTime) {

    String time = getTime(dateTime);
    String date = getDate(dateTime);
    String month = getMonthName(dateTime);
    String year = getYear(dateTime);

    if (kDebugMode) {
      print("Time: $time");
      print("Date: $date");
      print("Month: $month");
      print("Year: $year");
    }

    String result = "$time $date $month $year";
    return result;
  }
}