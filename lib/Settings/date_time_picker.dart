import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TimeOfDay currentTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }


  Future<void> _selectTime(BuildContext context) async {

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final DateTime currentDateTime = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isAfter(currentDateTime)) {
        setState(() {
          _selectedTime = selectedTime;
        });
      } else {
        // Handle invalid selection (past time)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Selection'),
              content: Text('Please select a future time.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DateTime Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              selectedDate.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 40),
            Text(
              'Selected Time:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _selectedTime!=null?
              _selectedTime!.format(context):
              currentTime!.format(context),

              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}