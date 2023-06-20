import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/E-cards/preview_screen.dart';

import '../Reminders/reminders_list.dart';
import '../constants/constants.dart';

class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<String> birthdayMessage=[];
  List<String> greetingsMessages=[];
  List<String> birthdayImage=[];
  List<String> greetingsImage=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setListData();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text('BirthDay',style: kBoldTextStyle,)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: birthdayImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20,top: 20,left: 10,right: 10),
                    child:
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (x)=>EcardPreviewScreen(listIncommingData: birthdayMessage,
                        strImageAsset: birthdayImage[index].toString(),
                        )));

                      },
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(birthdayImage[index].toString(),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),

                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            Align(
                alignment: Alignment.topLeft,
                child: Text('Greetings',style: kBoldTextStyle,)),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: greetingsImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20,top: 20,left: 10,right: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (x)=>EcardPreviewScreen(listIncommingData: greetingsMessages,
                          strImageAsset: greetingsImage[index].toString(),
                        )));
                      },
                      child: Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(greetingsImage[index].toString(),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,

                          ),
                        ),
                      ),
                    ),

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setListData() {
    birthdayMessage=[
      'Wishing you a day filled with happiness and a year filled with joy. Happy birthday!',
      'Sending you smiles for every moment of your special day…Have a wonderful time and a very happy birthday!',
      'Hope your special day brings you all that your heart desires! Here’s wishing you a day full of pleasant surprises! Happy birthday!',
      'On your birthday we wish for you that whatever you want most in life it comes to you just the way you imagined it or better. Happy birthday!',
      'Sending your way a bouquet of happiness…To wish you a very happy birthday!',
      'Wishing you a beautiful day with good health and happiness forever. Happy birthday!',
    ];

    greetingsMessages=[
      ' Good morning, Dude. How was your night? Today is a new day full of new opportunities to be maximized. I hope you’ll get the best out of the day. Wishing you a beautiful day ahead.',
      'Hello dear, I wish you were nearby. I had been thinking about you. I want to believe you are doing great. Do have a lovely and incredible day ahead!',
      'Just as day and night do not cease, goodness won’t stop locating you. This day shall favor you my dearest. Good morning, happy new day.',

    ];
    birthdayImage=[
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      // 'assets/images/b2.jpg',
      // 'assets/images/b3.jpg',
      // 'assets/images/b4.jpg',
      // 'assets/images/b5.jpg',
    ];

    greetingsImage=[
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      'assets/images/google.jpg',
      // 'assets/images/g1.jpg',
      // 'assets/images/g2.jpg',
      // 'assets/images/g3.jpg',
      // 'assets/images/g4.jpg',
      // 'assets/images/g5.jpg',

    ];
  }
}




