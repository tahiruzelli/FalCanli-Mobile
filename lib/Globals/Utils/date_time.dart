import 'package:intl/intl.dart';

String formatDateTime(DateTime date) {
  var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
  var outputDate = outputFormat.format(date);

  return outputDate.toString().split(" ")[0];
}

String dateToTimeStamp(DateTime date) {
  return date.toString().split(" ")[0] + "T" + date.toString().split(" ")[1];
}
