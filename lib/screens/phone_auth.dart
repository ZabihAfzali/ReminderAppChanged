import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/utils/utils.dart';

import '../Homescreens/homescreen.dart';


class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  var phoneNumberController=TextEditingController();
  var codeController=TextEditingController();
  bool isCodeSent=false;
  String verificationId="";
  String codeCheck="verify code";
  bool isVerified=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  VerifyPhoneNumber(BuildContext context) async {

    String phoneNumer=phoneNumberController.text.toString();

    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$phoneNumer',
        timeout: const Duration(seconds: 120),


        verificationCompleted: (PhoneAuthCredential credential) {
          print("Hello Firebase Auth ${credential.smsCode}");
          PhoneNumberAuthComplete(context,credential.smsCode.toString());
          this.verificationId=credential.verificationId!;

          setState(() {
            codeController.text=credential.smsCode!;
            if(codeController==credential.smsCode){
              codeCheck="verified";
              isVerified=true;

            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Hello firebase auth Verificaion failed ${e.toString()}");
        },
        codeSent: (String verificationId, int? resendToken) {
          print("Hello firebase auth Code sent");

          this.verificationId=verificationId;

          setState(() {
            isCodeSent=true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("hello firebaseAuth codeAutoRetrievalTimeout called");
          this.verificationId=verificationId;
        },
      );
    } on FirebaseAuthException catch(error, _){
      print("Hello FirebaseAuthExceptionCalled ${error.toString()}");
    }
    catch (e){
      print("firebaseAuthError called ${e.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {

    GestureTapCallback onTapVerify=(){
      if(!isCodeSent){
        VerifyPhoneNumber(context);
      }
      else{
        String sms_Code=codeController.text.toString();
        PhoneNumberAuthComplete(context,sms_Code);
      }
    };

    return  Scaffold(
      appBar: AppBar(
        title: Text("phone auth"),

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(hintText: "Enter  phone number"),
              ),
            ),Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: codeController,

                decoration: InputDecoration(hintText: "Enter  Code  here"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    onTapVerify();
                  },
                  child: Container(
                    child: Text(
                      "Send code",style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.cyan,
                    ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: InkWell(
                    onTap: (){

                      VerifyPhoneNumber(context);

                      if(isVerified==true){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                          return HomeScreen();
                        }));
                      }
                      else{
                        utils.toastMessage('OTP code verification failed');
                      }
                    },
                    child: Container(
                      child: Text(
                        "$codeCheck",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.cyan,
                      ),
                      ),
                    ),
                  ),
                ),

              ],

            )


          ],
        ),
      ),
    );
  }

  void PhoneNumberAuthComplete(BuildContext context, String sms_Code) async{
    PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: sms_Code);
  }




}
