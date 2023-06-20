

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

  Future<void> initializeNotifications() async {
    final initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
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



















class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  List<String> imageNames = [
    'assets/images/google.jpg',
    'assets/images/google.jpg',
    'assets/images/google.jpg',

  ];

  Future<void> _shareAssetImage(String imageName) async {
    try {
      final bytes = await rootBundle.load('$imageName');
      final List<int> imageData = bytes.buffer.asUint8List();


      final tempDir = await getTemporaryDirectory();
      // print('File path: ${tempDir.path}');

      final file_path = await File('${imageName}').path;
      // file.writeAsBytesSync(imageData);
      print('File path: ${file_path}');


      Share.shareFiles(['${file_path}'], text: 'Great picture');

    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: ListView.builder(
        itemCount: imageNames.length,
        itemBuilder: (context, index) {
          final imageName = imageNames[index];
          return ListTile(
            title: Text('Image ${index + 1}'),
            leading: Image.asset(imageNames[index].toString()),
            trailing: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                _shareAssetImage(imageName);
              },
            ),
          );
        },
      ),
    );
  }
}
//
