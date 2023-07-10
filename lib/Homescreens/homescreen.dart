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
import 'package:reminder_app/E-cards/e_card_screen.dart';
import 'package:reminder_app/Reminders/reminders_list.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/screens/login_screen.dart';
import 'package:reminder_app/utils/utils.dart';
import '../Databases/DateFormatDatabase/dateFormat_box.dart';
import '../Databases/DateFormatDatabase/dateFormat_model.dart';
import '../Settings/profile_settings.dart';
import '../Settings/settings.dart';
import '../TestingScreen/test_screen.dart';
import 'add_event_screen.dart';
import 'event_list_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  String strEventName='';
  User? currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('user');


  int _selectedIndex = 0;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();


  var pages =[
    const EventsList(),
    const ECardsScreen(),
  ];
  int selectedPage = 0;


  @override
  void dispose() {
    _descriptionController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //dateFormat= DateFormat(context.watch<DateFormatProvider>().dateFormat);
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
          backgroundColor: Colors.orangeAccent,
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
                            color: Colors.white,
                            fontSize: 40,
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
                            color: Colors.red,
                            fontSize: 40,
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
                            color: Colors.white,
                            fontSize: 40,
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
                            color: Colors.white,
                            fontSize: 40,
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
                            color: Colors.white,
                            fontSize: 40,
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
        body: pages[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          items: kBottomNavigationBar,
          currentIndex: selectedPage,
          selectedItemColor:const Color(0xffEB5757),
          onTap: _onItemTapped,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            top: 90,
          ),
          child: FloatingActionButton(
            autofocus: false,
            isExtended: false,
            backgroundColor: Colors.transparent,
            onPressed: () {
              _addEvents(context);
            },
            child:  Image.asset(
              'assets/svg_pics/add.png',
              width: 70,
              height: 70,
            ),
          ),
        ),
      ),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  void _addEvents(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return const AddEventsScreen();
      },
    );
  }

  void shareAppLink() {

  }





}
