import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Homescreens/homescreen.dart';

import 'Databases/DateFormatDatabase/dateFormat_model.dart';

import 'Databases/Hive_database/hive_database_box.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(DateFormatModelAdapter());
  await Hive.openBox<DateFormatModel>('dateformat');

  HiveDatabaseBox.GetHiveInitFunction();


  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


