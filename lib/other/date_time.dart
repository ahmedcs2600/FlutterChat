import 'package:intl/intl.dart';

const DATE_FORMAT_SERVER = "yyyy-MM-dd'T'HH:mm:ss";

String getCurrentUtcDateTime() {
  return DateTime.now().toUtc().dateToStr(DATE_FORMAT_SERVER);
}




extension AppDateTime on DateTime {


  String dateToStr(String dateFormat) => DateFormat(dateFormat).format(this);
}