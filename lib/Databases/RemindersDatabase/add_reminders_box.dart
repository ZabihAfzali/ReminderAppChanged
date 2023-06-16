import 'package:hive/hive.dart';
import 'add_reminders_model.dart';




class Boxes{
  static Box<AddRemindersModel> getData()=>Hive.box('addReminders');
}