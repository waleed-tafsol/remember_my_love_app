String formatISOToCustom(String isoTime) {
  // Parse the ISO time string to a DateTime object
  DateTime dateTime = DateTime.parse(isoTime);

  // Get day name
  List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
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
