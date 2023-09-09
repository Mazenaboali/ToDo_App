import 'package:intl/intl.dart';

class MyDateUtils
{
  static String FormateTaskDate(DateTime dateTime)
  {
    DateFormat formater=DateFormat('dd/MM/yyyy');
    return formater.format(dateTime);
  }
  static DateTime ExtractDateonly(DateTime dateTime)
  {
        return DateTime(dateTime.year,dateTime.month,dateTime.day);
  }
}