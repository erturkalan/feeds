import 'package:intl/intl.dart';

extension DateExtension on int {
  String get getFormattedDate {
    var date = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}
