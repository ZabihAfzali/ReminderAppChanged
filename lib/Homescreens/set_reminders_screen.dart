import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/utils/utils.dart';
import '../Databases/DateFormatDatabase/dateFormat_box.dart';
import '../Databases/Hive_database/hive_database.dart';
import '../Databases/Hive_database/hive_database_box.dart';
import '../Reminders/reminders_list.dart';
import '../constants/constants.dart';
class SetReminderScreen extends StatefulWidget {

  final DataEvent dataEvent;
  SetReminderScreen({
    required this.dataEvent,
});
  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}
class _SetReminderScreenState extends State<SetReminderScreen> {
  late bool _isCheckedNoti = false;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  String? strDateFormat;
  DateTime selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TimeOfDay currentTime = TimeOfDay.now();
  List<String> listOfData=[];
  String? strDateTime;
  DataEvent? dataEvent;
  Box box_event=HiveDatabaseBox.GetDataEvent();
  DateTime? dateTime;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      dataEvent=widget.dataEvent;
    });
  }


  bool toggleEditable() {
    setState(() {
      _isCheckedNoti = !_isCheckedNoti;
    });
    return _isCheckedNoti;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration:  BoxDecoration(
              border: Border.all(
                  color: Colors.black,
                  width: 2
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: const Color(0xffEB5757),
            ),
            child:   Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Set Reminder',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Reminder Name',
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            strDateTime==null? 'Select Date and  Time'
                                : '$strDateTime'
                          ),
                        ),
                        IconButton(onPressed: (){
                          _selectDate(context);
                        }, icon: Icon(Icons.calendar_month_outlined))
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Show Notification',
                            style: kBoldSmallStyle,
                          ),
                          Checkbox(
                            activeColor: const Color(0xffFFBD12),
                            fillColor: MaterialStateProperty.all(const Color(0xffFFBD12)),
                            focusColor: const Color(0xffFFBD12),
                            value: _isCheckedNoti == true ? true : false,
                            onChanged: (bool? value) {
                              setState(() {
                                _isCheckedNoti=value!;
                              });
                            },),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed:(){
                        addDataToReminderDatabaseList(widget.dataEvent);

                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states){
                            if(states.contains(MaterialState.pressed)){
                              return Color(0xff1500DB);

                            }
                            return Color(0xff1500DB);
                          }),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          )
                      ),
                      child:const Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'Montserrat'
                        ),
                        textAlign: TextAlign.start,
                      ),

                    ),
                  ),



                ],
              ),


            ),
          ),
        ]
    );


  }


  Future<void> _selectDate(BuildContext context) async {

    try {
      Box dateFormatBox = DateFormatBox.getDateFormatBox();
      // var data = box.values.toList().cast<DateFormatModel>();
      strDateFormat = dateFormatBox.get("1").dateFormat.toString();

      print('Date format This hive recieved data $strDateFormat');
    }catch(e){
      utils.toastMessage(e.toString());
    }
    if(strDateFormat==null){
      strDateFormat='EEEE, MMMM d, yyyy';
    }


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
        _selectTime(context,strDateFormat!);
      });
    }
  }


  Future<void> _selectTime(BuildContext context,String format) async {



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
      dateTime = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour, selectedTime.minute);


      if (dateTime!.isAfter(DateTime.now())) {
        setState(() {
          _selectedTime = selectedTime;
          strDateTime=DateFormat(format+'h:mm a').format(dateTime!).toString();});
      } else {
        // Handle invalid selection (past time)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Sele ction'),
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

  Future<void> addDataToReminderDatabaseList(DataEvent dataEvent) async{
    // DataEvent dataEvent=widget.dataEvent;
    DataReminder data_reminder = DataReminder()
      ..key = HiveDatabaseBox.getNewKey().toString()
      ..description=_descriptionController.text
      ..dateTime=dateTime!;
    dataEvent.list_reminders.add(data_reminder);

    print('values are ${data_reminder.toString()}');

    box_event.put(dataEvent.key.toString(), dataEvent);

    print('values are ${dataEvent.list_reminders.toList().toString()}');
    Navigator.push(context, MaterialPageRoute(builder: (ctx){
      return RemindersScreen(dataEvent: dataEvent,);
    }));


  }
}