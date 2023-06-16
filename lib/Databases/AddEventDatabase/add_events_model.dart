import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part   'add_events_model.g.dart';


@HiveType(typeId: 0)
class AddEventModel extends HiveObject{

  @HiveField(0)
  String eventName="";




  AddEventModel({required this.eventName});
}