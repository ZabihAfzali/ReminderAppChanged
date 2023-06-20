import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatExample extends StatefulWidget {
  @override
  _DateFormatExampleState createState() => _DateFormatExampleState();
}

class _DateFormatExampleState extends State<DateFormatExample> {
  final DateTime dateTime = DateTime.now();
  String selectedFormat = 'Default';

  void changeDateFormat(String? format) {
    setState(() {
      selectedFormat = format ?? 'Default';
    });
  }

  String formatDate(DateTime dateTime) {
    switch (selectedFormat) {
      case 'yyyy-MM-dd':
        return DateFormat('yyyy-MM-dd').format(dateTime);
      case 'dd/MM/yyyy':
        return DateFormat('dd/MM/yyyy').format(dateTime);
      case 'EEEE, MMMM d, yyyy':
        return DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
      default:
        return dateTime.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Formats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Format: $selectedFormat',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              formatDate(dateTime),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Choose Format:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ListTile(
              title: const Text('Default'),
              leading: Radio<String>(
                value: 'Default',
                groupValue: selectedFormat,
                onChanged: changeDateFormat,
              ),
            ),
            ListTile(
              title: const Text('yyyy-MM-dd'),
              leading: Radio<String>(
                value: 'yyyy-MM-dd',
                groupValue: selectedFormat,
                onChanged: changeDateFormat,
              ),
            ),
            ListTile(
              title: const Text('dd/MM/yyyy'),
              leading: Radio<String>(
                value: 'dd/MM/yyyy',
                groupValue: selectedFormat,
                onChanged: changeDateFormat,
              ),
            ),
            ListTile(
              title: const Text('EEEE, MMMM d, yyyy'),
              leading: Radio<String>(
                value: 'EEEE, MMMM d, yyyy',
                groupValue: selectedFormat,
                onChanged: changeDateFormat,
              ),
            ),
          ],
        ),
      ),
    );
  }
}