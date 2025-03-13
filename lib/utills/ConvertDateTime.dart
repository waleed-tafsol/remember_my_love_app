String formatISOToCustom(String isoTime) {
  DateTime dateTime = DateTime.parse(isoTime);
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  String dayName = days[dateTime.weekday - 1];

  // Get month name
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String monthName = months[dateTime.month - 1];

  // Format day, month, and year
  String day = dateTime.day.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  // Format time to 12-hour format
  int hour = dateTime.hour > 12
      ? dateTime.hour - 12
      : dateTime.hour == 0
          ? 12
          : dateTime.hour;
  String minute = dateTime.minute.toString().padLeft(2, '0');
  String period = dateTime.hour >= 12 ? "PM" : "AM";

  // Combine into desired format
  return "$dayName, $day $monthName $year - ${hour.toString().padLeft(2, '0')}:$minute $period";
}

String formatISOToCustomWithLocal(String isoTime) {
  // Parse the ISO time string to a DateTime object
  DateTime dateTime =
      DateTime.parse(isoTime).toLocal(); // Convert to local time

  // Get day name
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  String dayName = days[dateTime.weekday - 1];

  // Get month name
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String monthName = months[dateTime.month - 1];

  // Format day, month, and year
  String day = dateTime.day.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  // Format time to 12-hour format
  int hour = dateTime.hour > 12
      ? dateTime.hour - 12
      : dateTime.hour == 0
          ? 12
          : dateTime.hour;
  String minute = dateTime.minute.toString().padLeft(2, '0');
  String period = dateTime.hour >= 12 ? "PM" : "AM";

  // Combine into desired format
  return "$dayName, $day $monthName $year - ${hour.toString().padLeft(2, '0')}:$minute $period";
}

String convertTimeToMinutesAgo(String isoDateTime) {
  // Parse the ISO 8601 string into a DateTime object
  DateTime receivedTime = DateTime.parse(isoDateTime);

  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the difference in minutes
  int minutesAgo = now.difference(receivedTime).inMinutes;

  // Return the result as a formatted string
  if (minutesAgo == 0) {
    return "Just now";
  } else if (minutesAgo < 60) {
    return "$minutesAgo min ago";
  } else if (minutesAgo < 1440) {
    int hoursAgo = minutesAgo ~/ 60;
    return "$hoursAgo hr${hoursAgo > 1 ? 's' : ''} ago";
  } else {
    int daysAgo = minutesAgo ~/ 1440;
    return "$daysAgo day${daysAgo > 1 ? 's' : ''} ago";
  }
}

String formattedTimeZoneOffset(DateTime time) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final duration = time.timeZoneOffset,
      hours = duration.inHours,
      minutes = duration.inMinutes.remainder(60).abs().toInt();

  return '${hours > 0 ? '+' : '-'}${twoDigits(hours.abs())}:${twoDigits(minutes)}';
}

String getOffsetInHours() {
  DateTime localTime = DateTime.now();
  Duration offset = localTime.timeZoneOffset;
  int offsetInHours = offset.inHours;
  return '$offsetInHours';
}

DateTime adjustDateWithOffset(DateTime date, {bool addOffset = true}) {
  // Get the current time zone offset (from UTC)
  Duration offset = DateTime.now().timeZoneOffset;

  // Adjust the date by adding or subtracting the offset
  if (addOffset) {
    return date.add(offset); // Add the offset to the selected date
  } else {
    return date.subtract(offset); // Subtract the offset from the selected date
  }
}


bool hasDatedPassed(String? deliveryDate) {
  if (deliveryDate == null || deliveryDate.isEmpty) {
    return false; // If deliveryDate is null or empty, it hasn't passed (consider it invalid)
  }

  DateTime deliveryDateTime = DateTime.parse(deliveryDate).toLocal();
  return deliveryDateTime.isBefore(DateTime.now()); // Return true if delivery date is before the current time
}

