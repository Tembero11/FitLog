abstract class ExtraDateUtils {
  static const monthNames = [
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
  static const weekdayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  static getMonthName(int monthIndex) => monthNames[monthIndex];
  static getDayName(int dayIndex) => weekdayNames[dayIndex];
}
