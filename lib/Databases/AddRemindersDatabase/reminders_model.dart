import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part   'reminders_model.g.dart';

@HiveType(typeId: 0)
class AddEventModel extends HiveObject{

  @HiveField(0)
  String eventName="";

  AddEventModel({required this.eventName});
}

@HiveType(typeId: 1)
class RemindersModel extends HiveObject{

  @HiveField(0)
  String eventName="";

  @HiveField(1)
  String description="";

  @HiveField(2)
  String date="";

  @HiveField(3)
  String time="";

  RemindersModel({required this.eventName,required this.description,required this.date,required this.time});
}

