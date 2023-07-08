import 'package:flutter/material.dart';
class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  int current_index = 0;
  List<String> list = [
    'Language1',
    'Language2',
    'Language3',
    'Language4',
  ];
  // Color getColor(Set<MaterialState> states) {
  //   const Set<MaterialState> interactiveStates = <MaterialState>{
  //     MaterialState.pressed,
  //     MaterialState.hovered,
  //     MaterialState.focused,
  //   };
  //   if (states.any(interactiveStates.contains)) {
  //     return  const Color(0xffFFBD12);
  //   }
  //   return Colors.red;
  // }

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
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      'Select Language',
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
                      child: Icon(
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
                              fillColor: MaterialStateProperty.all(const Color(0xffFFBD12)),
                              focusColor: const Color(0xffFFBD12),
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
