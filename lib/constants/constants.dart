import 'package:flutter/material.dart';

const kBoldTextStyle=TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
  color: Colors.black,
  fontFamily: 'Times New Roman',
);

const kBoldSmallStyle=TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Colors.black,
  fontFamily: 'Times New Roman',
);
const kSimpleText=TextStyle(
  fontSize: 15,
  color: Colors.black,
  fontFamily: 'Montserrat',
);
const kFourhText=TextStyle(
    fontSize: 20,
    color: Colors.black54,
    fontFamily: 'Times New Roman'
);

const  kBottomNavigationBar =  [
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month),
    label: 'Events',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.add,size: 40,
    ),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.card_giftcard),
    label: 'E-cards',
  ),
];

