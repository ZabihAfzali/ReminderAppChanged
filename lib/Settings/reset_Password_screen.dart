import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:reminder_app/utils/utils.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var myKey=GlobalKey<FormState>();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  var passwordOb = true;
  var confirmPasswordOb = true;
  var password,confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: myKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80,),
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
              const SizedBox(height: 50,),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),

                ),
              ),
              SizedBox(height: 20,),

              TextFormField(
                obscureText: passwordOb,
                controller: passwordController,
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
                  hintText: 'New Password',
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

                validator: (value)
                {
                if (value!.isEmpty) {
                return 'Please enter your password';
                }
                // Add email format validation if needed
                return null;
                },
              ),
              const SizedBox(height: 30,),
              TextFormField(
                obscureText: confirmPasswordOb,
                controller: confirmPasswordController,
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
                   if (value!.isEmpty) {
                   return 'Please confirm your password';
                   }
                   if (value != passwordController.text) {
                   return 'Passwords do not match';
                   }
                   return null;
                  }

              ),
              const SizedBox(height: 20,),
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
                      updatePassword(context,confirmPasswordController.text);
                      Navigator.pop(context);
                      print('new password is : ${confirmPasswordController.text.toString()} ');
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
                    'Update',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontFamily: 'Montserrat'
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Future<void> updatePassword(BuildContext context,String password) async{
    print('update password ${passwordController.text}');
    ProgressDialog progressDialog = ProgressDialog(context,
      message: const Text("Updating password"),
      title: const Text("Please wait..."),
    );
    progressDialog.show();
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    DatabaseReference dbRef=FirebaseDatabase.instance.ref().child('user');
    User? currentUser = FirebaseAuth.instance.currentUser;

    await currentUser!.updatePassword(password).then((value){
      progressDialog.dismiss();
      Navigator.pop(context);
    }).onError((error, stackTrace){
      progressDialog.dismiss();
      utils.toastMessage(error.toString());
    });
  }
}
