import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'e_card_preview.dart';


class ECardsScreen extends StatefulWidget {
  const ECardsScreen({Key? key}) : super(key: key);

  @override
  State<ECardsScreen> createState() => _ECardsScreenState();
}

class _ECardsScreenState extends State<ECardsScreen> {

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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  'BirthDay',
                  style:TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: birthdayImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: 10,
                        right: 10),
                    child:
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (x)=>
                            ECardsPreviewScreen(listIncommingData: birthdayMessage,
                              strImageAsset: birthdayImage[index].toString(),
                            )));
                      },
                      child: Container(
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1),
                          image: DecorationImage(
                            image: AssetImage('${ birthdayImage[index].toString()}'), // Replace with your image asset
                            fit: BoxFit.cover, // Set the fit property to cover the container
                          ),
                        ),


                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  'Greetings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: greetingsImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: 10,
                        right: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (x)=>ECardsPreviewScreen(
                              listIncommingData: greetingsMessages,
                              strImageAsset: greetingsImage[index].toString(),
                            )));
                      },
                      child: Container(
                        width: 200,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage(greetingsImage[index].toString()),
                            fit: BoxFit.cover,
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
      'Happy birthday!',
      'Sending you smiles ',
      'Hope your special ',
      'On your birthday  ',
      'Happy birthday!',
      'Wishing you a beautiful day',
      'Wishing you a beautiful day',
      'Wishing you a beautiful day',
      'Wishing you a beautiful day',
    ];
    greetingsMessages=[
      '  Today is a new day',
      'I want to believe',
      'This day shall favor you',
    ];
    birthdayImage=[
      'assets/images/card1.jpg',
      'assets/images/bcard2.jpg',
      'assets/images/bcard3.jpg',
      'assets/images/bcard4.jpg',
      'assets/images/card5.jpg',
    ];
    greetingsImage=[
      'assets/images/gcard7.jpeg',
      'assets/images/gcard3.png',
      'assets/images/gcard4.jpg',
      'assets/images/gcard5.png',
      'assets/images/gcard6.jpg',

    ];
  }
}




