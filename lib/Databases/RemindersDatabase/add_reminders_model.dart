import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part   'add_reminders_model.g.dart';


@HiveType(typeId: 1)
class AddRemindersModel extends HiveObject{

  @HiveField(0)
  String eventName="";

  @HiveField(1)
  String description="";

  @HiveField(2)
  String dateTime="";




  AddRemindersModel({required this.eventName,required this.description,required this.dateTime,});
}