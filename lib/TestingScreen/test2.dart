import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class AlarmScheduler extends StatefulWidget {
  @override
  _AlarmSchedulerState createState() => _AlarmSchedulerState();
}

class _AlarmSchedulerState extends State<AlarmScheduler> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late DateTime selectedDateTime;


  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializeNotifications();
    selectedDateTime = DateTime.now();
  }
  Future<void> copySoundFileFromAssets() async {
    final soundFileName = 'alarm_sound.mp3'; // Replace with your sound file name
    final soundFilePath = await _getSoundFilePath(soundFileName);
    if (!await File(soundFilePath).exists()) {
      final ByteData byteData = await rootBundle.load('assets/sounds/$soundFileName');
      final Uint8List soundData = byteData.buffer.asUint8List();
      await File(soundFilePath).writeAsBytes(soundData);
    }
  }

  Future<String> _getSoundFilePath(String soundFileName) async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    return '${appDocumentsDirectory.path}/$soundFileName';
  }

  Future<void> initializeNotifications() async {
    final initializationSettingsAndroid =
    AndroidInitializationSettings('logor');
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(DateTime dateTime) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Alarm Channel',
      'Channel for scheduling alarms',
      importance: Importance.max,
      priority: Priority.high,

      sound: RawResourceAndroidNotificationSound('alarm_sound.mp3'),
      enableLights: true,
      playSound: true,
      color: Colors.deepOrange,
      ledColor: Colors.deepOrange,
      ledOnMs: 1000, // Specify the LED on duration in milliseconds
      ledOffMs: 500,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Alarm',
      'Alarm triggered at ${DateFormat('HH:mm').format(dateTime)}',
      dateTime,
      platformChannelSpecifics,
    );
  }

  Future<void> pickDateTime() async {
    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDateTime != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final newDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          selectedDateTime = newDateTime;
        });
        scheduleNotification(newDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Scheduler'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date and Time:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              DateFormat('MMM dd, yyyy - HH:mm').format(selectedDateTime),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickDateTime,
              child: Text('Pick Date and Time'),
            ),
          ],
        ),
      ),
    );
  }
}