import 'package:hive/hive.dart';

import 'add_events_model.dart';




class Boxes{
  static Box<AddEventModel> getData()=>Hive.box('addEvent');
}