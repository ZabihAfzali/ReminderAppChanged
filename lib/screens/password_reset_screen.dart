import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:reminder_app/utils/utils.dart';
class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {

  final _formKey = GlobalKey<FormState>();
  bool pawwwordOb=true;
  bool confirmPawwwordOb=true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Reset your  password here:',style: kBoldSmallStyle,),
                  SizedBox(height: 20,),
                  TextFormField(
                    obscureText: pawwwordOb,
                    controller: _passwordController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Enter New Password',
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed:(){
                          setState(() {
                            pawwwordOb=!pawwwordOb;
                          });
                        },
                        icon: pawwwordOb? Icon(
                          Icons.visibility_off,
                          size: 30,
                        ):
                            Icon(Icons.visibility,
                              size: 30,
                            ),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add email format validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Retype Password',

                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed:(){
                          setState(() {
                            confirmPawwwordOb=!confirmPawwwordOb;
                          });
                        },
                        icon: confirmPawwwordOb? Icon(
                          Icons.visibility_off,
                          size: 30,
                        ):
                        Icon(Icons.visibility,
                          size: 30,
                        ),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      // Add email format validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                 onPressed: () {
                      if (_formKey.currentState!.validate()) {
                          updatePassword(context,_confirmPasswordController.text);
                          Navigator.pop(context);
                      }
                    },
                    child: Text('Save',style: TextStyle(
                        fontSize: 15
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> updatePassword(BuildContext context,String password) async{
    print('update password ${_passwordController.text}');
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
