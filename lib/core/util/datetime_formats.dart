import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  return DateFormat.yMd().add_jm().format(dateTime);
}

String getFormattedDateTimeSmall(DateTime dateTime) {
  return DateFormat.Md().add_jm().format(dateTime);
}
