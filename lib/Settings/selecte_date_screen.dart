import 'package:flutter/material.dart';
class SelectDateScreen extends StatefulWidget {
  const SelectDateScreen({Key? key}) : super(key: key);

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {

  int current_index = 0;


  List<String> list = [
    '12-May-2023',
    '12-5-2023',
    '5-12-2023',
    '2023-12-5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      'Select Date Format',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (contact, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            current_index = index;
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: const Color(0xffFFBD12),
                              focusColor: Color(0xffFFBD12),
                              fillColor: MaterialStateProperty.all(Color(0xffFFBD12)),
                              value: current_index == index ? true : false,
                              onChanged: (bool? value) {
                                setState(() {
                                  current_index = index;
                                });
                              },),
                            Text(
                              "${list[index]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  width: double.infinity,
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
                      'Ok',
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
          ]
      ),
    );
  }

}
