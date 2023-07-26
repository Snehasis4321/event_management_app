import 'package:intl/intl.dart';

formatTime(String time) {
  DateTime dateTime = DateTime.parse(time);

  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}

formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
  return formattedDate;
}
