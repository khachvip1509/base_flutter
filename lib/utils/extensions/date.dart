import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String formatDateToStringYYYYMMDD() {
    DateFormat dateFormat = DateFormat("yyyyMMdd");
    String string = dateFormat.format(this);
    return string;
  }

  String formatDateToString({String format = "dd/MM/yyyy"}) {
    DateFormat dateFormat = DateFormat(format);
    String string = dateFormat.format(this);
    return string;
  }

  String formatTimeToString() {
    DateFormat dateFormat = DateFormat("HH:mm");
    String string = dateFormat.format(this);
    return string;
  }
}
