import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/Hive_database/hive_database_box.dart';
import 'package:reminder_app/Reminders/selection_search_screen.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:reminder_app/screens/login_screen.dart';
import 'package:reminder_app/utils/utils.dart';
import 'package:intl/intl.dart';

import '../Databases/DateFormatDatabase/dateFormat_box.dart';
import '../Databases/Hive_database/hive_database.dart';




class RemindersScreen extends StatefulWidget {
  final DataEvent? dataEvent;

   RemindersScreen({this.dataEvent,});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {

  List<String> listIncommingData=[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _searchEventController = TextEditingController();
  List<DataReminder> listSearchedItems = [];
  String? strSearchResult;
  bool _showNotification = false;
  bool _showOnCalendar = false;
  String? strDateFormat;
  int? searchIndex;
  DataEvent? dataEvent;



  DateTime selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TimeOfDay currentTime = TimeOfDay.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataEvent=widget.dataEvent;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchEventController.dispose();
    listSearchedItems.clear();
  }

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
       backgroundColor: Colors.orangeAccent,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/svg_pics/back_arrow.svg',
                      height: 50,
                      width: 50,
                    ),
                  ),
                  const SizedBox(width: 60,),
                  const Text(
                    'Reminders',style: kBoldSmallStyle,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _searchEventController,
                  onChanged: (String value) {
                    if(value.length > 0) {
                      searchItems(value);
                    }
                   else {
                      listSearchedItems = [];
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Search here',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:const EdgeInsets.fromLTRB(20,10,20,10),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: const Color(0xffF95A2C),
                            border: Border.all(
                              width: 2,
                            )
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
              Expanded(
                child: listSearchedItems.length == 0 ? GetListView(widget.dataEvent!.event_name, widget.dataEvent!.list_reminders) : GetListView(widget.dataEvent!.event_name, listSearchedItems))
            ],
          ),
        )
      ),
    );
  }


   GetListView(String event_name, List<DataReminder> list_reminders ) {
    return ListView.builder(
      //reverse: true,
        itemCount: list_reminders.length,
        itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.only(
          left:5,
          right: 6,
          top: 6,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: ListTile(
            title: Text('${event_name}'),
            subtitle: Text('${list_reminders[index].description}'),
            leading: SvgPicture.asset(
              'assets/svg_pics/splash.svg',
              width: 50,
              height: 50,
            ),
            trailing: InkWell(
              onTap: (){
                // showMenuDialog(listSearchedItems[index],listSearchedItems[index].event_name,
                //   listSearchedItems[index].list_reminders[2].toString(),);
              },
              child:SvgPicture.asset(
                'assets/svg_pics/vertical.svg',
                height: 20,
              ),
            ),
          ),
        ),
      );
    });
  }


  showMenuDialog(DataEvent addReminderModel,String eventName, String description,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 200, // Adjust the width as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    _showReminderDialogue(context,eventName,description,);

                    // Handle Edit option
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                  onTap: () {
                    delete(addReminderModel);
                    // Handle Delete option
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _showReminderDialogue(BuildContext context,String eventName,String description) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Column(
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
                    child: const Center(
                      child: Text(
                        'Set Reminder',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),


                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
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
                                BorderSide(color: Colors.black, width: 1.0),
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
                                return 'Please enter description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _dateTimeController,
                            decoration:  InputDecoration(
                              hintText: 'Select Date and Time',
                              suffixIcon:IconButton(
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon:  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  )
                              ),

                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CheckboxListTile(
                              title: const Text('Show Notification'),
                              value: timeDilation != 1.0,
                              onChanged: (bool? value) {
                                setState(() {
                                  timeDilation = value! ? 10.0 : 1.0;
                                });
                              },
                              secondary: const Icon(Icons.hourglass_empty),
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
            )
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {

    try {
      //Box dateFormatBox = DateFormatBox.getDateFormatBox();

      // var data = box.values.toList().cast<DateFormatModel>();
     // strDateFormat = dateFormatBox.get("1").dateFormat.toString();

      print('Date format This hive recieved data $strDateFormat');
    }catch(e){
      utils.toastMessage(e.toString());
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
      DateTime dateTime = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour, selectedTime.minute);

      if (dateTime.isAfter(currentDateTime)) {
        setState(() {
          _selectedTime = selectedTime;
          _dateTimeController.text=DateFormat(format+'h:mm a').format(dateTime).toString();});
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



  void searchItems(String entered_search_text) async {


    // var box = HiveDatabaseBox.GetDataEvent();
    //
    // var databasee_list_remider =box.values.toList().cast<DataEvent>();

    listSearchedItems = [];

    widget.dataEvent!.list_reminders.forEach((DataReminder dataReminder) {
      if(dataReminder.description.trim().toLowerCase().contains(entered_search_text.trim().toLowerCase())) {
        print('objectobjectobject  ${dataReminder.description.trim().toLowerCase()}');
        print('objectobjectobject  ${entered_search_text.trim().toLowerCase()}');
        listSearchedItems.add(dataReminder);
      }
    });

    print('objectobjectobject  ${listSearchedItems.length}');

    setState(() {});

  }

  void delete(DataEvent remindersModel) async{
    remindersModel.delete();
  }



  // Future<void> searchCalender(BuildContext context) async {
  //
  //   try {
  //     Box dateFormatBox = DateFormatBox.getDateFormatBox();
  //     //var data = box.values.toList().cast<DateFormatModel>();
  //     strDateFormat = dateFormatBox.get("1").dateFormat.toString();
  //
  //     print('Date format This hive recieved data $strDateFormat');
  //   }catch(e){
  //     utils.toastMessage(e.toString());
  //   }
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialEntryMode: DatePickerEntryMode.input,
  //     initialDate: selectedDate,
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );
  //
  //   if (pickedDate != null && pickedDate != selectedDate) {
  //     setState(() {
  //       selectedDate = pickedDate;
  //       searchDateFromCalender(selectedDate.toString());
  //     });
  //   }
  // }
  // void searchDateFromCalender(String entered_search_text) async {
  //   var box = HiveBox.getReminderDataBox();
  //
  //   var databasee_list_remider =box.values.toList().cast<RemindersModel>();
  //
  //   listSearchedItems = [];
  //
  //   databasee_list_remider.forEach((RemindersModel remindersModel) {
  //     if(remindersModel.date.trim().toLowerCase().contains(entered_search_text.trim().toLowerCase())) {
  //       listSearchedItems.add(remindersModel);
  //     }
  //   });
  //
  //   setState(() {
  //
  //   });
  //
  // }

}
