import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controllers/google_signUp_controller.dart';
import '../../constants/constants.dart';
import '../controllers/sign_up_controller.dart';
import 'login_screen.dart';
import 'package:flutter_svg/svg.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool readOnly=false;
  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  var passwordOb = true;
  var confirmPasswordOb = true;
  var myKey=GlobalKey<FormState>();
  var name,email,mobileNo,address,location,password,confrimPassword, business;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
        Form(
        key: myKey,
        child:Padding(
          padding: const EdgeInsets.only(
              top: 40,
              right: 15,
              left: 15
          ),

       child: Column(
        children: [

          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg_pics/back_arrow.svg',
                  width: 50,
                ),
              ],
            ),
          ),
          SizedBox(height: 60,),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'SignUp',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        const SizedBox(height: 20,),
          TextFormField(
            controller: _nameController,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration:const InputDecoration(
              prefixIcon: Icon(
                Icons.person_outline,
                size: 24,
                color: Colors.black,
              ),
              hintText: 'Name',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
              fillColor: Colors.white,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),

            validator: (value){
              if(value!.isEmpty||!RegExp(r'^[a-zA-Z\s]*$',).hasMatch(value)){
                return 'please provide your name';
              }else{
                name=value;
                return null;
              }
            },
          ),
        const SizedBox(height: 10,),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              prefixIcon:Icon(
                Icons.email_outlined,
                color: Colors.black,
                size: 24,
              ),
              hintText: 'Email Address',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
              fillColor: Colors.black,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),

            validator: (value){
              if(value!.isEmpty||!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)){
                return 'please provide your email';
              }else{
                email=value;
                return null;
              }
            },
          ),
        const SizedBox(height: 10,),
          TextFormField(
            obscureText: passwordOb,
            controller: _passwordController,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
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
              hintText: 'Password',
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
              fillColor: Colors.white,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),

            validator: (value){
              if(value!.isEmpty){
                return 'please provide your password';
              }else{
                password=value;
                return null;
              }
            },
          ),
        const SizedBox(height: 10,),
          TextFormField(
            obscureText: confirmPasswordOb,
            controller: _confirmPasswordController,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixIcon:IconButton(
                onPressed: (){
                  setState(() {
                    confirmPasswordOb=!confirmPasswordOb;
                  });

                },
                icon: Icon(confirmPasswordOb?
                Icons.visibility_off_outlined: Icons.visibility_outlined,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              prefixIcon:const Icon(
                Icons.lock_outline,
                color: Colors.black,
                size: 24,
              ),
              hintText: 'Confirm Password',
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Montserrat',
              ),
              fillColor: Colors.black,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),

            validator: (value){
              if(value!.isEmpty){
                return 'please confirm  your  password ';
              }else{
                confrimPassword=value;
                return null;
              }
            },
          ),
        const SizedBox(height: 10,),
        ChangeNotifierProvider(create: (_)=>SignUpController(),
        child: Consumer<SignUpController>(
          builder: (context,provider,child){
            return
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed:(){
                    if (myKey.currentState!.validate()) {
                      // Form is valid, perform signup logic
                      // Add your signup implementation here
                      provider.signUp(context,_nameController.text,_emailController.text,_confirmPasswordController.text);

                    }
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
                    'Sign Up',
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
          },
        ),
        ),

        const Text(
        'OR',
        style: kBoldSmallStyle,
        ),
        const SizedBox(
        height: 10,
        ),
                            ChangeNotifierProvider(create: (_)=>SignInWithGoogle(),
                            child: Consumer<SignInWithGoogle>(
                              builder: (context,provider,child){
                                return
                                  Container(
                                    width: double.infinity,
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
                                            left: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/google.png',
                                                scale: 15,
                                              ),
                                              const SizedBox(width: 5,),
                                              const Text(
                                                'Continue with Google',
                                                style: TextStyle(
                                                    fontSize: 18,
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
                              },
                            ),
                            ),
                          ],

        ),
    ),
        ),
        ),
        ),
      ),
    );
  }
}