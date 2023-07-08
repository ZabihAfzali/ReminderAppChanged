import 'package:hive/hive.dart';
part 'dateFormat_model.g.dart';



@HiveType(typeId: 2)
class DateFormatModel extends HiveObject{

  @HiveField(0)
  String dateFormat="";

  DateFormatModel({required this.dateFormat});
}