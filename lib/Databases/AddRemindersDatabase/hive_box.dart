import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/AddRemindersDatabase/reminders_model.dart';





class HiveBox{

  static Box<RemindersModel> getReminderDataBox()=>Hive.box('reminders');

  static Box<AddEventModel> getEventDataBox()=>Hive.box('addEvent');


}