import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/RemindersDatabase/add_reminders_model.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:intl/intl.dart';
import '../Databases/RemindersDatabase/add_reminders_box.dart';


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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.listIncommingData != null) {
      setState(() {
        listIncommingData = widget.listIncommingData!;
        _addEvent();
      });
      // if(_searchEventController!=null){
      //   setState(() {
      //     searchItems(_searchEventController.text);
      //   });
      // }
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
                      Navigator.pop(context);
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
                    setState(() {

                    });
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
                          searchItems(_searchEventController.text);
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
        ValueListenableBuilder<Box<AddRemindersModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context,box,_){
            var data=box.values.toList().cast<AddRemindersModel>();
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
                        '${data[index].dateTime}'),
                    leading: SvgPicture.asset('assets/svg_pics/splash.svg',height: 20,width: 20,),
                    trailing: InkWell(
                        onTap: (){
                          showMenuDialog(data[index],data[index].eventName,data[index].description,data[index].dateTime);
                        },
                        child: Icon(Icons.menu,size: 20,)),
                  ),
                ),
              );
            });
          },

        ):Text('${listSearchedItems.toList().toString()}'),

      ),
    );
  }


  showMenuDialog(AddRemindersModel addReminderModel,String eventName, String description,String dateTime) {
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
                    _showReminderDialogue(context,eventName,description,dateTime);

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

  void _showReminderDialogue(BuildContext context,String eventName,String description,String dateTime) {
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
                          addDataToReminderDatabaseList(eventName,description,dateTime);
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

  void _addEvent() {

      final data = AddRemindersModel(eventName: listIncommingData[0],
        description: listIncommingData[1], dateTime: listIncommingData[2],);
      final box = Boxes.getData();
      box.add(data);

      print('This is box.length ${listIncommingData}' );
      print(box);


  }



  void searchItems(String searchTerm) async {
    if (Hive.isBoxOpen('addreminders')) {
      // Access the box
      var box = Hive.box<AddRemindersModel>('addReminders');
      print('box is opened');

      final searchResults = box.values.where((addReminders) =>
          addReminders.eventName.toLowerCase().contains(searchTerm.toLowerCase()));

      setState(() {
        if(searchResults.length> 0) {
          listSearchedItems = [];
          for (var item in searchResults) {
            strSearchResult=item.eventName;
            if(_searchEventController!=null) {
              listSearchedItems.add(item.eventName);
              print('Searched item result ${item.eventName}');
              print('Searched list result ${listSearchedItems}');
            }
          }
        }
      });
      await box.close();

      // Perform operations on the box
      // ...
    }else {
      final box = await Hive.openBox('addReminders');
    }


    // Perform case-insensitive search


    // Close the box when you're done
  }

  void delete(AddRemindersModel addReminderModel) async{
    addReminderModel.delete();
  }

  void addDataToReminderDatabaseList(String eventName,String description,String dateTime) {
    final data = AddRemindersModel(eventName: eventName,
      description: description, dateTime: dateTime,);
    final box = Boxes.getData();
    box.add(data);

    print('This is box.length ${listIncommingData}' );
    print(box);

  }
}
