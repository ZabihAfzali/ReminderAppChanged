import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboardingScreen.dart';
import 'package:reminder_app/widgets_reusing/onboarding_widget.dart';
import 'package:reminder_app/constants/constants.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=> const OnboardingScreen())));
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor:Color(0xff1947E5),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Spacer(
                      flex: 1,
                    ),
                   SvgPicture.asset(
                       'assets/svg_pics/splash.svg',
                   ),
                    Spacer(flex: 1,),

                    const Text(
                        'PRODUCT BY',
                      style: kSplashText1,
                    ),
                    const Text(
                        'CODEMATIC',
                      style: kSplashText2,
                    ),
                    Spacer(),

                  ]
              ),
            ),
          )
      ),
    );
  }
}
