import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/AddRemindersDatabase/hive_box.dart';
import 'package:reminder_app/Databases/AddRemindersDatabase/reminders_model.dart';
import 'package:reminder_app/Homescreens/homescreen.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;



class RemindersScreen extends StatefulWidget {
  final List<String>? listIncommingData;
   RemindersScreen({this.listIncommingData});

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
  List<String> listSearchedItems = [];
  String? strSearchResult;

  bool _showNotification = false;
  bool _showOnCalendar = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TimeOfDay currentTime = TimeOfDay.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.listIncommingData != null) {
      setState(() {
        listIncommingData = widget.listIncommingData!;
        _addEvent();
      });
    }
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: 180,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (x)=>HomeScreen()));

                    }, icon: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: 60,),
                    Text('Reminders',style: kBoldSmallStyle,),
                  ],
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _searchEventController,
                  onChanged: (String value) {
                    searchItems(value);
                  },
                  decoration: InputDecoration(
                      hintText: 'Search here',
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusColor: Colors.blue,
                      filled: true,
                      fillColor: Colors.white,



                      suffixIcon: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.arrow_drop_down,size: 40,),
                      )
                  ),
                ),


              ],
            ),
          ),
        ),
        body: listSearchedItems.length ==0?
        ValueListenableBuilder<Box<RemindersModel>>(
          valueListenable: HiveBox.getReminderDataBox().listenable(),
          builder: (context,box,_){
            var data=box.values.toList().cast<RemindersModel>();
            return ListView.builder(
              //reverse: true,
                itemCount: box.length,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),

                    title: Text('${data[index].eventName}'),
                    subtitle: Text('${data[index].description}\n'
                        '${data[index].date}  ${data[index].time}'),
                    leading: SvgPicture.asset('assets/svg_pics/splash.svg',height: 20,width: 20,),
                    trailing: InkWell(
                        onTap: (){
                          showMenuDialog(data[index],data[index].eventName,data[index].description,);
                        },
                        child: Icon(Icons.menu,size: 20,)),
                  ),
                ),
              );
            });
          },

        ):ListView.builder(
          //reverse: true,
            itemCount: listSearchedItems.length,itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                shape: RoundedRectangleBorder( //<-- SEE HERE
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),

                title: Text('${listSearchedItems[0]}'),
                subtitle: Text('${listSearchedItems[1]}\n'
                    '${listSearchedItems[2]}  ${listSearchedItems[3]}'),
                leading: SvgPicture.asset('assets/svg_pics/splash.svg',height: 20,width: 20,),

              ),
            ),
          );
        }),

      ),
    );
  }


  showMenuDialog(RemindersModel addReminderModel,String eventName, String description,) {
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
                                addDataToReminderDatabaseList(eventName,description,);
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

  void _addEvent() {

      final data = RemindersModel(eventName: listIncommingData[0],
        description: listIncommingData[1], date: listIncommingData[2],time: listIncommingData[3]);
      final box = HiveBox.getReminderDataBox();
      box.add(data);

      print('This is box.length ${listIncommingData}' );
      print(box);


  }



  void searchItems(String searchTerm) async {


    var box = HiveBox.getReminderDataBox();


        final searchResults = box.values.where((RemindersModel) =>
            RemindersModel.eventName.toLowerCase().contains(searchTerm.toLowerCase()));



        if(searchResults.length> 0) {
          List<String> list=[];
          listSearchedItems = [];
          for (var item in searchResults) {
            strSearchResult=item.eventName;
            if(_searchEventController!=null) {
              listSearchedItems.add(item.eventName);
              listSearchedItems.add(item.description);
              listSearchedItems.add(item.date);
              listSearchedItems.add(item.time);
              print('Searched list result ${list.length}');
            }
          }
          print('Searched list result ${listSearchedItems.length}');


        }
        else{
          print('Empty list');
        }

    setState(() {

    });

  }

  void delete(RemindersModel remindersModel) async{
    remindersModel.delete();
  }

  void addDataToReminderDatabaseList(String eventName,String description) {
    final data = RemindersModel(eventName: eventName,
        description: _descriptionController.text, date: selectedDate.toString(),time: _selectedTime.toString());
    final box = HiveBox.getReminderDataBox();
    box.add(data);

    print(box);

  }
}
