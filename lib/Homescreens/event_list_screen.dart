import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminder_app/Databases/Hive_database/hive_database.dart';
import 'package:reminder_app/Homescreens/set_reminders_screen.dart';
import 'package:reminder_app/Reminders/reminders_list.dart';
import 'package:reminder_app/Settings/settings.dart';
import '../Databases/Hive_database/hive_database_box.dart';
enum Options {
  Edit,
  Delete,
}
class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  var _popupMenuItemIndex = 0;
  int current_index = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _eventNameController = TextEditingController();
  String? strDateFormat;
  Box box_event=HiveDatabaseBox.GetDataEvent();


  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        body: ValueListenableBuilder<Box<DataEvent>>(
          valueListenable: HiveDatabaseBox.GetDataEvent().listenable(),
          builder: (context,box,_){
            List<DataEvent> data=box.values.toList().cast<DataEvent>();
            return data.length>0?
             Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 50,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'EVENTS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:Color(0xff474A57),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      //reverse: true,
                        itemCount: box.length,itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            return RemindersScreen(dataEvent: data[index],);
                          }));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffE9E7FC),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg_pics/bell.svg',
                                          height: 40,
                                          width: 40,
                                        ),
                                        Positioned(
                                          width: 20,
                                          height: 20,
                                          left: 10,
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.red,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${data[index].list_reminders.length.toString()}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 70,
                                  right: 10,

                                ),
                                child: ListTile(
                                  title: Text(
                                    maxLines: null,
                                    '${data[index].event_name.toString()}',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  trailing: InkWell(
                                    onTap: (){
                                      _popUpMenu(context,data[index],data[index].event_name.toString());
                                    },
                                    child: SvgPicture.asset(
                                      'assets/svg_pics/vertical.svg',
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                height: 45,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    )

                                ),
                                child: ElevatedButton(
                                  onPressed:(){
                                    _showReminderDialogue(context,data[index]);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith((states){
                                        if(states.contains(MaterialState.pressed)){
                                          return Color(0xffFFBD12);

                                        }
                                        return Color(0xffFFBD12);
                                      }),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          )
                                      )
                                  ),
                                  child:const Text(
                                    'Set Reminder',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                        fontFamily: 'Montserrat'
                                    ),
                                    textAlign: TextAlign.start,
                                  ),

                                ),
                              ),
                            ],
                          ),

                        ),
                      );
                    }),
                  ),
                ],
              ),
            ):
                Text('Empty data Events');
          },

        ),


      ),
    );
  }

  void _popUpMenu(BuildContext context,DataEvent addEventModel,String eventName){
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(300, 300, 30, 300),
      items: [
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'edit') {
        // Handle edit button tap
        showEditDialogue(addEventModel, eventName);
        print('Edit button tapped');
      } else if (value == 'delete') {
        // Handle delete button tap
        delete(addEventModel);
        print('Delete button tapped');
      }
    });
  }

  Future<void> showEditDialogue(DataEvent addEventModel, String evenName) async{



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
                    addEventModel.event_name = _eventNameController.text;
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

  void delete(DataEvent addEventModel) async{
    addEventModel.delete();
  }

  void _showReminderDialogue(BuildContext context,DataEvent dataEvent) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return  SingleChildScrollView(child: SetReminderScreen(dataEvent: dataEvent,));
      },
    );
  }

}


