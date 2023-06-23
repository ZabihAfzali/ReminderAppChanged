import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Homescreens/homescreen.dart';
import 'package:reminder_app/Databases/AddRemindersDatabase/reminders_model.dart';
import 'package:reminder_app/screens/Splash%20screen.dart';
import 'package:reminder_app/screens/email_verification_screen.dart';
import 'package:reminder_app/screens/forgot_screen.dart';
import 'package:reminder_app/screens/login_screen.dart';
import 'package:reminder_app/screens/phone_auth.dart';
import 'package:reminder_app/screens/sign_up_screen.dart';
import 'package:reminder_app/TestingScreen/test2.dart';
import 'package:reminder_app/TestingScreen/test_screen.dart';

import 'Databases/DateFormatDatabase/dateFormat_model.dart';
import 'E-cards/E_cards_screen.dart';
import 'E-cards/preview_screen.dart';
import 'Reminders/reminders_list.dart';
import 'Settings/profile_settings.dart';
import 'Settings/settings.dart';
import 'controllers/SettingsProvider.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(AddEventModelAdapter());
  await Hive.openBox<AddEventModel>('addEvent');
  Hive.registerAdapter(RemindersModelAdapter());
  await Hive.openBox<RemindersModel>('Reminders');
  Hive.registerAdapter(DateFormatModelAdapter());
  await Hive.openBox<DateFormatModel>('dateformat');


  runApp(ChangeNotifierProvider(
      create: (context) => DateFormatProvider(),
      child: MyApp(),
    ),
  );
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
      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


