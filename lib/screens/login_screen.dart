import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controllers/google_signUp_controller.dart';
import 'package:reminder_app/controllers/sign_in_controller.dart';
import 'package:reminder_app/screens/forgot_screen.dart';
import 'package:reminder_app/screens/phone_auth.dart';
import 'package:reminder_app/screens/sign_up_screen.dart';


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
              const SizedBox(height: 100,),
              const Text(
                ' Login ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'Times New Roman',
                ),
                textAlign: TextAlign.start,

              ),
              const SizedBox(height: 50,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Email address',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  suffixIcon: const Icon(
                    Icons.visibility, color: Colors.black54,),
                  prefixIcon: const Icon(Icons.email, color: Colors.black54,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),


              ),
              const SizedBox(height: 20,),
              TextField(
                  obscureText: passwordOb,
                  controller: passwordController,

                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: '***********',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusColor: Colors.orangeAccent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordOb = !passwordOb;
                        });
                      },
                      icon: Icon(
                          passwordOb ?
                          Icons.visibility_off : Icons.visibility
                      ),
                      focusColor: Colors.teal,
                      color: Colors.black54,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black54,
                      size: 40,
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return PhoneAuthScreen();
                      }));
                    },
                    child: const Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1500DB),
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
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
                        return
                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 50,
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  provider.signIn(context, emailController.text,
                                      passwordController.text);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith((states) {
                                      if (states.contains(
                                          MaterialState.pressed)) {
                                        return Colors.yellow;
                                      }
                                      return Colors.yellow;
                                    }),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0),
                                        )
                                    )
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.start,
                                ),

                              )
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
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((
                            states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xff1500DB);
                          }
                          return const Color(0xff1500DB);
                        }),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                      ),
                      child: ChangeNotifierProvider(
                        create: (_) => SignInWithGoogle(),
                        child: Consumer<SignInWithGoogle>(
                          builder:(context,provider,child){
                            return InkWell(
                              onTap: (){
                                provider.googleSignUp(context);
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/google.jpg',
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
                            );
                      }
    ),
                      ),
                    )

                ),
              ),

              const SizedBox(height: 20,),
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
                        return SignupScreen();
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