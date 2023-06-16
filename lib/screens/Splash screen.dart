import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reminder_app/screens/login_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Homescreens/homescreen.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool _isFirstLaunch = false;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    setState(() {
      _isFirstLaunch = isFirstLaunch;
    });

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      // Wait for splash screen duration
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {

      // Navigate to the home screen or wherever you want to go
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLaunch) {
      // Show splash screen
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: SvgPicture.asset(
                    'assets/svg_pics/splash.svg',
                    semanticsLabel: 'Splash SVG',
                  ),
                ),
                SizedBox(height: 140,),
                Text(
                "PRODUCT BY",
                style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w500,
                    color:Colors.white,
                    fontFamily: "Montserrat"
                ),
              ),
                Text(
                  "CODEMATICS",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                      fontFamily: "Bebas"


                  ),
                ),
            ]
            ),

          ),
        ),
      );
    }

    // Otherwise, return an empty container to prevent the splash screen from showing
    return Container();
  }
}


