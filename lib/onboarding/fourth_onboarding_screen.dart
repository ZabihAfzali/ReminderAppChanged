import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import 'package:reminder_app/screens/login_screen.dart';

class FourthOnBoardingScreen extends StatelessWidget {
  const FourthOnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 80,
          left: 50,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                  'assets/svg_pics/illus 4.svg',
              ),
            ),
            const Text(
              'SET EVENT REMINDER &',
              style:kFourhText,
            ),
            const SizedBox(height: 10,),
            const Text(
              'Enjoy',
              style: kBoldTextStyle,
            ),
            const Text(
                'Remember',
              style: kBoldTextStyle,
            ),
            const Text(
                'Me App',
              style: kBoldTextStyle,
            ),

            const SizedBox(height: 10,),
            Container(
              width: 250,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
              ),
              child: ElevatedButton(
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return const LoginScreen();
                  }));

                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states){
                      if(states.contains(MaterialState.pressed)){
                        return Color(0xff1500DB);
                      }
                      return Color(0xff1500DB);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                    ),
                ),
                child:const Text(
                  'Get Started  > ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
