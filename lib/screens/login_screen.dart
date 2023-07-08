import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controllers/google_signUp_controller.dart';
import 'package:reminder_app/controllers/sign_in_controller.dart';
import 'package:reminder_app/screens/forgot_screen.dart';
import 'package:reminder_app/screens/phone_auth.dart';
import 'package:reminder_app/screens/sign_up_screen.dart';
import 'package:reminder_app/screens/signup.dart';


import '../Homescreens/homescreen.dart';
import '../constants/constants.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordOb = true;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  ' Login ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.start,

                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding:const EdgeInsets.fromLTRB(20,10,20,10),
                  filled: true,
                  fillColor:Colors.grey.shade200,
                  hintText: 'Email address',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                  prefixIcon:const Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),

              ),
              const SizedBox(height: 20,),
              TextField(
                  obscureText: passwordOb,
                  controller: passwordController,

                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.fromLTRB(20,10,20,10),
                    filled: true,
                    fillColor:Colors.grey.shade200,
                    hintText: '***********',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                    focusColor: Colors.orangeAccent,
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.black, width: 2.0),
                    ),
                    suffixIcon:IconButton(
                      onPressed: (){
                        setState(() {
                          passwordOb=!passwordOb;
                        });
                      },
                      icon: Icon(passwordOb ?
                      Icons.visibility_off_outlined: Icons.visibility_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    prefixIcon:Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                      size: 24,
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return ForgotPasswordScreen();
                      }));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1500DB),
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(

                height: 20,
              ),
              ChangeNotifierProvider(create: (_) => SignInController(),
                  child: Consumer<SignInController>(
                      builder: (context, provider, child) {
                        return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                        onPressed:(){
                          provider.signIn(context, emailController.text,
                              passwordController.text);
                        },
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states){
                        if(states.contains(MaterialState.pressed)){
                        return Color(0xffFFBD12);

                        }
                        return Color(0xffFFBD12);
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        )
                        )
                        ),
                        child:const Text(
                        'Login',
                        style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontFamily: 'Montserrat'
                        ),
                        textAlign: TextAlign.start,
                        ),

                        ),
                        );
                      }
                  )
              ),
              const Text(
                'OR',
                style: kBoldSmallStyle,
              ),
              const SizedBox(

                height: 20,
              ),
              ChangeNotifierProvider(
              create: (_) => SignInWithGoogle(),
              child: Consumer<SignInWithGoogle>(
              builder:(context,provider,child){
             return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
            onPressed:(){
              provider.googleSignUp(context);
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
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    scale: 20,
                  ),
                  const SizedBox(width: 5,),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'Montserrat'
                    ),
                  ),

                ],
              ),
            )

        ),
      );
    }
    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have account?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return Signup();
                      }));
                    },

                    child: const Text(
                      'Create Here',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
