// ignore_for_file: file_names

import 'package:intl/intl.dart';

String formatDateTime(String originalDate) {
  DateTime dateTime = DateTime.parse(originalDate).toLocal();

  String formattedDate = DateFormat(
    'dd/MM/yyyy - h:mm a',
    'ar',
  ).format(dateTime).replaceAll('AM', 'ص').replaceAll('PM', 'م');

  return formattedDate;
}

String formatDate(date) {
  DateTime dateTime = date.runtimeType == String
      ? DateTime.parse(date).toLocal()
      : date;

  return DateFormat('d MMMM , yyy', 'ar').format(dateTime);
}

String formatDateWithDay(date) {
  final DateTime dateTime = date is String
      ? DateTime.parse(date).toLocal()
      : (date as DateTime);

  return DateFormat('EEEE d MMMM', 'ar').format(dateTime);
}

String formatDateWithDayAndTime(date) {
  final DateTime dateTime = date is String
      ? DateTime.parse(date).toLocal()
      : (date as DateTime);
  return DateFormat('EEEE d MMMM h:mm a', 'ar').format(dateTime);
}

String formatTimeAgo(dynamic dateInput) {
  // 👇 التحقق من نوع المتغير
  DateTime dateTime = dateInput is String
      ? DateTime.parse(dateInput).toLocal()
      : (dateInput as DateTime).toLocal();

  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    final s = diff.inSeconds;
    if (s < 3) return 'الآن';
    if (s < 11) return 'منذ ثوانٍ';
    return 'قبل $s ثانية';
  } else if (diff.inMinutes < 60) {
    final m = diff.inMinutes;
    if (m == 1) return 'قبل دقيقة';
    if (m == 2) return 'قبل دقيقتين';
    if (m < 11) return 'قبل $m دقائق';
    return 'قبل $m دقيقة';
  } else if (diff.inHours < 24) {
    final h = diff.inHours;
    if (h == 1) return 'قبل ساعة';
    if (h == 2) return 'قبل ساعتين';
    if (h < 11) return 'قبل $h ساعات';
    return 'قبل $h ساعة';
  } else if (diff.inDays < 7) {
    final d = diff.inDays;
    if (d == 1) return 'قبل يوم';
    if (d == 2) return 'قبل يومين';
    if (d < 11) return 'قبل $d أيام';
    return 'قبل $d يوم';
  } else if (diff.inDays < 30) {
    final w = (diff.inDays / 7).floor();
    if (w == 1) return 'قبل أسبوع';
    if (w == 2) return 'قبل أسبوعين';
    return 'قبل $w أسابيع';
  } else if (diff.inDays < 365) {
    final m = (diff.inDays / 30).floor();
    if (m == 1) return 'قبل شهر';
    if (m == 2) return 'قبل شهرين';
    return 'قبل $m أشهر';
  } else {
    final y = (diff.inDays / 365).floor();
    if (y == 1) return 'قبل سنة';
    if (y == 2) return 'قبل سنتين';
    return 'قبل $y سنوات';
  }
}

String convertTo12Hour(String time24) {
  // تقسيم النص "HH:mm" إلى ساعتين ودقائق
  final parts = time24.split(':');
  int hour = int.parse(parts[0]);
  final minute = parts.length > 1 ? parts[1] : '00';

  // تحديد AM أو PM
  final period = hour >= 12 ? 'PM' : 'AM';

  // تحويل الساعة إلى نظام 12 ساعة
  if (hour == 0) {
    hour = 12; // منتصف الليل → 12 AM
  } else if (hour > 12) {
    hour -= 12;
  }

  // إرجاع النتيجة بالتنسيق المطلوب
  return '$hour:$minute $period';
}
