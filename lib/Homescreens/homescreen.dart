import 'dart:async';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/AddRemindersDatabase/hive_box.dart';
import 'package:reminder_app/Databases/AddRemindersDatabase/reminders_model.dart';
import 'package:reminder_app/E-cards/E_cards_screen.dart';
import 'package:reminder_app/Reminders/reminders_list.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/screens/login_screen.dart';

import '../Settings/profile_settings.dart';
import '../Settings/settings.dart';
import '../test_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  List<String> listOfData=[];
  String strEventName='';
  User? currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('user');

  DateTime selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TimeOfDay currentTime = TimeOfDay.now();



  int _selectedIndex = 0;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  bool _showNotification = false;
  bool _showOnCalendar = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          toolbarHeight: 100,
          flexibleSpace: const Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Reminder App',style: kBoldTextStyle,),
                ]
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                splashColor: Colors.yellow,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return RemindersScreen();
                  }));
                },
                child: const Icon(
                  CupertinoIcons.bell,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: ()
                          {
                            Navigator.pop(context);
                          }, icon:const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 35,
                        ),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Menu',
                          style: kBoldSmallStyle,

                        )

                      ],
                    ),
                    const SizedBox(height: 50,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (tx)=>ProfileScreen()));

                      },
                      child:   const Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 50,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (tx)=>RemindersScreen()));

                      },
                      child:  const Text(
                        'Reminder',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 50,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (x)=>SettingScreen()));
                      },
                      child:  const Text(
                        'Setting',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 50,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        shareAppLink();
                      },
                      child:  const Text(
                        'Share',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 50,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        FirebaseAuth.instance.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (tx)=>LoginScreen()));


                      },
                      child:  const Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 50,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<AddEventModel>>(
          valueListenable: HiveBox.getEventDataBox().listenable(),
          builder: (context,box,_){
            var data=box.values.toList().cast<AddEventModel>();
            return ListView.builder(
              //reverse: true,
                itemCount: box.length,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2),
                    color: Colors.cyan,

                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${data[index].eventName.toString()}',style: kBoldSmallStyle,),
                          InkWell(
                            onTap: (){
                              showMenuDialog(data[index],data[index].eventName.toString());

                            },child: Icon(Icons.menu,size: 20,color: Colors.black,),
                          )
                        ],
                      ),
                      SizedBox(height: 50,),
                      ElevatedButton(onPressed: (){
                        _showReminderDialogue(context,data[index].eventName);


                      }, child: Text('Set Reminder',style: kSimpleText,))
                    ],
                  ),

                ),
              );
            });
          },

        ),

        bottomNavigationBar: BottomNavigationBar(

          items: kBottomNavigationBar,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }


  void bottomNavigatorItems(){
    _selectedIndex = 0;
    const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Events',
        style: optionStyle,
      ),
      Text(
        'Index 1: AddEvent',
        style: optionStyle,
      ),
      Text(
        'Index 2: Ecards',
        style: optionStyle,
      ),
    ];

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Call your function or perform any action specific to the selected item
      if (_selectedIndex == 0) {
        // Call a function related to the first item
        // ...
      } else if (_selectedIndex == 1) {
        // Call a function related to the second item
        showMyDialog();

      } else if (_selectedIndex == 2) {
        // Call a function related to the third item
        // ...
        Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return MyScreen();
        }));
      }
    });
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.yellow,
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Add Event',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close_sharp,size: 30,)),

                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter event name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                ),
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addEvent() {
    if (_formKey.currentState!.validate()) {
      // Perform your logic to add the event here

        final data = AddEventModel(eventName: _eventNameController.text,);
        final box = HiveBox.getEventDataBox();
        box.add(data);

        print('This is box.length ${box.length}' );
        print(box);



      //data.save();


      _eventNameController.clear();
      Navigator.of(context).pop();
    }
  }

  showMenuDialog(AddEventModel addEventModel, String eventName) {
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

                    showEditDialogue(addEventModel,eventName);
                    // Handle Edit option
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                  onTap: () {
                    delete(addEventModel);
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


  Future<void> showEditDialogue(AddEventModel addEventModel, String evenName) async{



    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.yellow,
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Add Event',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close_sharp,size: 30,)),

                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter event name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
        if (_formKey.currentState!.validate()) {
          addEventModel.eventName = _eventNameController.text;
          addEventModel.save();
          Navigator.pop(context);
        }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                ),
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );




  }


  void delete(AddEventModel addEventModel) async{
    addEventModel.delete();
  }

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
        _selectTime(context);
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
          _dateTimeController.text=_selectedTime.toString()!+' '+selectedDate.toString()!;
        });
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


  void _showReminderDialogue(BuildContext context,String eventName) {
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
                                return 'Please enter a name';
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
                                addDataToReminderDatabaseList(eventName);

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

  Future<void> addDataToReminderDatabaseList(String eventName) async{

      listOfData.add(eventName);
      listOfData.add(_descriptionController.text);
      listOfData.add(selectedDate.toString().trim());
      listOfData.add(_selectedTime.toString().trim());
      _descriptionController.clear();
      _dateTimeController.clear();


    Navigator.push(context, MaterialPageRoute(builder: (ctx){
      return RemindersScreen(listIncommingData: listOfData);
    }));


  }

  void shareAppLink() {}







}
