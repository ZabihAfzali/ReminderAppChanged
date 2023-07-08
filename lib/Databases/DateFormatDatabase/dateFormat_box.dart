import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/DateFormatDatabase/dateFormat_model.dart';
class DateFormatBox{

  static Box<DateFormatModel> getDateFormatBox()=>Hive.box('dateformat');

}