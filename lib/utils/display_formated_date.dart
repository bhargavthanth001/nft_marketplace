import 'package:intl/intl.dart';

String formattedDate(String date) {
  final formattedDate =
      DateFormat("EEE MMMM d yyyy hh:mm aaa ").format(DateTime.parse(date));
  return formattedDate;
}
