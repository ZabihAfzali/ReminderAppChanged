import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/Databases/Hive_database/hive_database.dart';
import 'package:reminder_app/Databases/Hive_database/hive_database_box.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);
  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}
class _AddEventsScreenState extends State<AddEventsScreen> {
  TextEditingController _eventNameController = TextEditingController();
  List<String> listOfData=[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Box box_event=HiveDatabaseBox.GetDataEvent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 700,
      width: double.infinity,
      child: Form(
        key: _formKey,
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
                  color: const Color(0xffFFBD12),
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        'Add Event',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'Montserrat'

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _eventNameController,
                      decoration:  const InputDecoration(
                        hintText: ' Enter Event Name',
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
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                            onPressed:()
                            {
                              _addEvent();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states){
                                  if(states.contains(MaterialState.pressed)){
                                    return const Color(0xff1500DB);

                                  }
                                  return const Color(0xff1500DB);
                                }),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )
                                )
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'
                              ),
                            ),
                          )


                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }


  void _addEvent() {
    if (_formKey.currentState!.validate()) {
      // Perform your logic to add the event here

      String strEventName=_eventNameController.text;

      DataEvent dataEvent=DataEvent()
      ..key=HiveDatabaseBox.getNewKey()
      ..event_name=strEventName
      ..list_reminders=[];

      box_event.put(HiveDatabaseBox.getNewKey().toString(), dataEvent);



      //data.save();


      _eventNameController.clear();
      Navigator.of(context).pop();
    }
  }

}