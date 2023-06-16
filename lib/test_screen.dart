import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDialogueBox extends StatefulWidget {
  @override
  _ReminderDialogueBoxState createState() => _ReminderDialogueBoxState();
}

class _ReminderDialogueBoxState extends State<ReminderDialogueBox> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  bool _showNotification = false;
  bool _showOnCalendar = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final DateFormat formatter = DateFormat('dd-MM-yy HH:mm');
        final String formattedDateTime = formatter.format(selectedDateTime);

        setState(() {
          _dateTimeController.text = formattedDateTime;
        });
      }
    }
  }

  void _showReminderDialogue(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.red[200],
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        'Set Reminder',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      suffixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: _selectDateTime,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date and Time',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: TextFormField(
                        controller: _dateTimeController,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Select Date and Time',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Show Notification',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showNotification
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          setState(() {
                            _showNotification = !_showNotification;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Show on Calendar',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showOnCalendar
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          setState(() {
                            _showOnCalendar = !_showOnCalendar;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String name = _nameController.text;
                          final String dateTime = _dateTimeController.text;
                          final String reminder =
                              'Name: $name\nDate and Time: $dateTime\nShow Notification: $_showNotification\nShow on Calendar: $_showOnCalendar';

                          _showReminderNotification(reminder);
                          Navigator.pop(context);
                          _nameController.clear();
                          _dateTimeController.clear();
                          _showNotification = false;
                          _showOnCalendar = false;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 16.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showReminderNotification(String reminder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reminder Added'),
          content: Text(reminder),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showReminderDialogue(context);
          },
          child: Text('Open Reminder Dialogue'),
        ),
      ),
    );
  }
}













