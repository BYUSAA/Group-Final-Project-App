import 'package:intl/intl.dart';

abstract final class DateFormatters {
  static String session(DateTime value) => DateFormat('EEE d MMM · HH:mm').format(value);
  static String date(DateTime value) => DateFormat('EEEE d MMMM yyyy').format(value);
  static String day(DateTime value) => DateFormat('EEE').format(value);
  static String time(DateTime value) => DateFormat('HH:mm').format(value);
  static String timeRange(DateTime start, int durationMinutes) {
    final end = start.add(Duration(minutes: durationMinutes));
    return '${DateFormat('HH:mm').format(start)}–${DateFormat('HH:mm').format(end)}';
  }
}
