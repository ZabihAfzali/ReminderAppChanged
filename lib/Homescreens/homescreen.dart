import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/AddEventDatabase/add_events_model.dart';
import 'package:reminder_app/Databases/RemindersDatabase/add_reminders_model.dart';
import 'package:reminder_app/Reminders/reminders_list.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Databases/AddEventDatabase/AddEvent_box.dart';


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
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    child: ClipOval(
                      child: SvgPicture.asset(
                        'assets/svg_pics/splash.svg',
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider (
                  thickness: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){

                  },
                  child: Row(
                    children: const [
                      Icon(Icons.person, color: Colors.black, size: 30,),
                      SizedBox(width: 20,),
                      Text('Profile', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Icon(
                      Icons.alarm,
                      color: Colors.black,
                      size: 30,),
                    SizedBox(
                      width: 20,),
                    Text(
                      'Reminder',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: ()
                  {

                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 20,),
                      Text('Setting', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Icon(Icons.share, color: Colors.black, size: 30,),
                    SizedBox(width: 20,),
                    Text(
                      'Share',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: ()
                  {

                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 30,),
                      SizedBox(width: 20,),
                      Text(
                        'LogOut', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<AddEventModel>>(
          valueListenable: Boxes.getData().listenable(),
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
        final box = Boxes.getData();
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

  void _showReminderDialogue(BuildContext context,String eventName) {
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
                    controller: _descriptionController,
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
                          Navigator.pop(context);
                          addDataToReminderDatabaseList(eventName);
                          _descriptionController.clear();
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

  Future<void> addDataToReminderDatabaseList(String eventName) async{

      listOfData.add(eventName);
      listOfData.add(_descriptionController.text);
      listOfData.add(_dateTimeController.text);


    Navigator.push(context, MaterialPageRoute(builder: (ctx){
      return RemindersScreen(listIncommingData: listOfData);
    }));


  }






}
