import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reminder_app/Settings/settings.dart';
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


  List<String> events_list = [
    'Meeting ',
    'Birthday',
    'Weddings',
    'Mother Day',
    'Father Day',
  ];
  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        body: Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 50,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Events',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color:Color(0xff474A57),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  //reverse: true,
                    itemCount:events_list.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10
                        ),
                        child: Container(
                          height: 180,
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
                                    Container(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                              left: 5,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/svg_pics/bell.svg',
                                              height: 35,
                                              width: 35,
                                            ),
                                          ),
                                          Positioned(
                                            width: 18,
                                            height: 18,
                                            left: 14 ,
                                            top: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.red,
                                              ),
                                              child: const Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 3,
                                                  ),
                                                  child: Text(
                                                    '2',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 90,
                                  right: 5,

                                ),
                                child: ListTile(
                                  title: Text(
                                    '${events_list[index]}',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  trailing: InkWell(
                                    onTap: (){
                                      _popUpMenu(context);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/svg_pics/vertical.svg',
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 160,
                                height: 40,
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
                                    _showReminderDialogue(context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith((states){
                                        if(states.contains(MaterialState.pressed)){
                                          return const Color(0xffFFBD12);

                                        }
                                        return const Color(0xffFFBD12);
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
                                        fontSize: 15,
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
        ),


      ),
    );
  }

  void _popUpMenu(BuildContext context){
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
        print('Edit button tapped');
      } else if (value == 'delete') {
        // Handle delete button tap
        print('Delete button tapped');
      }
    });
  }

  void _showReminderDialogue(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return const SettingScreen();
      },
    );
  }
}


