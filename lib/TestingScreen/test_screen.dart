import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controllers/SettingsProvider.dart';
class DateTimePicker extends StatefulWidget {
  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {


    return Container(
      child: ElevatedButton(
        onPressed: () {
          showDateTimePicker(context,);
        },
        child: Text('Pick Date and Time'),
      ),
    );
  }

  void showDateTimePicker(BuildContext context) {
    final dateFormatProvider = Provider.of<DateFormatProvider>(context, listen: false);
    final dateFormat = dateFormatProvider.dateFormat;



    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            final dateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            final formatedDate=DateFormat(dateFormat).format(dateTime);


            setState(() {

            });
            //final formattedDateTime = dateFormat.format(dateTime);
            // Handle the selected date and time
            print('this is waht is printed ${dateFormat.toString()}');
            print('this is format ${formatedDate.toString()}');

          }
        });
      }
    });
  }
}
