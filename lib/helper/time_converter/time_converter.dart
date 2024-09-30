import 'package:intl/intl.dart';

class DateConverter {
  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String monthDateYear(DateTime dateTime) {
    return DateFormat('MMM dd yyyy').format(dateTime);
  }

  static String formatDetails(String dateString) {
    try {
      // Parse the ISO 8601 date string to a DateTime object
      DateTime inputDate = DateTime.parse(dateString);

      // Format the date to the desired format
      String outputFormat = DateFormat('dd MMM yyyy').format(inputDate);
      return outputFormat;
    } catch (e) {
      // Handle parsing error
      return '';
    }
  }

  static String formatDateYearMonth(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String hourMinit(DateTime utcDateTime) {
    DateTime localDateTime = utcDateTime.toLocal();
    String output = DateFormat('hh:mm a').format(localDateTime);
    return output;
  }

  static DateTime convertStringToDatetime() {
    DateTime now = DateTime.now();
    return now.toUtc();
  }

  static String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }

  ///=============== Calculate Time of Day ===============

  static String getTimePeriod() {
    // Get the current hour of the day
    int currentHour = DateTime.now().hour;

    // Define the boundaries for morning, noon, and evening
    int morningBoundary = 6;
    int noonBoundary = 12;
    int eveningBoundary = 18;

    // Determine the time period based on the current hour
    if (currentHour >= morningBoundary && currentHour < noonBoundary) {
      return "Good Morning";
    } else if (currentHour >= noonBoundary && currentHour < eveningBoundary) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
}
