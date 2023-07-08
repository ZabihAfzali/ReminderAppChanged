import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:reminder_app/screens/password_reset_screen.dart';
import 'package:reminder_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';
import '../controllers/sign_up_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reminder_app/Settings/reset_Password_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('user');
  Map<dynamic,dynamic>? mapData;
  bool _isEditName=false;
  bool _isEditEmail=false;
  bool _isEditPass=false;
  bool _isEditConfirm=false;
  bool hasImage=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  void toggleEditable() {
    setState(() {
      _isEditName = !_isEditName;
    });
  }
  void toggleEditEmail() {
    setState(() {
      _isEditEmail = !_isEditEmail;
    });
  }
  void toggleEditPass() {
    setState(() {
      _isEditPass = !_isEditPass;
    });
  }
  void toggleEditConfirm() {
    setState(() {
      _isEditConfirm = !_isEditConfirm;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10,left: 10,bottom: 5),
                    child: ChangeNotifierProvider(
                      create: (_)=> ProfileController(),
                      child: Consumer<ProfileController>(
                        builder: (context,provider,child){
                          return Form(
                        key: _formKey,
                        child: StreamBuilder(
                          stream: dbRef.child(currentUser!.uid.toString()).onValue,
                          builder: (context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            else if(snapshot.hasData){
                              mapData=snapshot.data.snapshot.value;
                              setInitialData();
                              return SingleChildScrollView(
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 40,),
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
                                        const SizedBox(width: 70,),
                                        const Text(
                                          'Profile',
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Montserrat',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Center(
                                    child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    mapData!['profile_image_url'.toString()],
                                                  ),
                                                fit: BoxFit.cover
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 80,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CircleAvatar(
                                                  radius: 200,
                                                  child: provider.image==null?mapData!['profile_image_url'].toString()
                                                    ==''? Image.asset('assets/images/person.jpeg'):
                                                Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    mapData!['profile_image_url'.toString()],
                                                  ),
                                                  loadingBuilder: (context,child,loadingProgress){
                                                    if(loadingProgress==null) return child;
                                                    return Center(child: CircularProgressIndicator(),);
                                                  },
                                                  errorBuilder: (context,object,stack){
                                                    return Container(child: Icon(Icons.error_outline,color: Colors.red),);
                                                  },
                                                ):
                                                  Image.file(File(provider.image!.path).absolute),
                                                ),
                                                ),
                                              ),
                                            ),

                                          Positioned(
                                            top: 100,
                                            left: 95,

                                            child: RawMaterialButton(

                                              elevation: 10,
                                              fillColor: Colors.white,
                                              padding: EdgeInsets.all(15.0),

                                              shape: CircleBorder(
                                                side: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                              ),
                                              onPressed: () {
                                                provider.pickImage(context);
                                              },
                                              child: const Icon(
                                                Icons.add_a_photo, size: 30,

                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  Text('Username',style: kBoldSmallStyle,),
                                  SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _nameController,
                                    readOnly: !_isEditName,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed:toggleEditable,
                                        icon: _isEditName ?const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ) : const Icon(
                                          Icons.edit,
                                          color: Colors.black,
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
                                        return 'Please enter your name';
                                      }
                                      // Add email format validation if needed
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.0),
                                  Text('Email Address',style: kBoldSmallStyle,),
                                  SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _emailController,
                                    readOnly: !_isEditEmail,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed:toggleEditEmail,
                                        icon: _isEditEmail ?const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ) : const Icon(
                                          Icons.edit,
                                          color: Colors.black,
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
                                        return 'Please enter your email';
                                      }
                                      if (!RegExp(
                                          "(^[a-zA-Z0-9_\\-\\.]+[@][a-z]+[\\.][a-z]{3}\$)",
                                          caseSensitive: false).hasMatch(value)) {
                                        return 'Email must be valid';
                                      }
                                      // Add email format validation if needed
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.0),
                                  Text('Password',style: kBoldSmallStyle,),
                                  SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _passwordController,
                                    readOnly: !_isEditPass,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: '*********',
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black
                                      ),
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed:(){
                                          Navigator.push(context, MaterialPageRoute(builder: (tx)=>ResetPasswordScreen()));
                                        },
                                        icon: _isEditPass ?const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ) : const Icon(
                                          Icons.edit,
                                          color: Colors.black,
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ElevatedButton(
                                          onPressed:()
                                          {
                                            if (_formKey.currentState!.validate()) {
                                              // Form is valid, perform signup logic
                                              // Add your signup implementation here
                                              if(_isEditName){
                                                provider.updateName(
                                                    context, _nameController.text);}
                                              if(_isEditEmail){
                                                provider.updateEmail(
                                                    context, _emailController.text.trim());}
                                            }
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.resolveWith((states){
                                                if(states.contains(MaterialState.pressed)){
                                                  return const Color(0xff1947E5);

                                                }
                                                return const Color(0xff1947E5);
                                              }),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                  )
                                              )
                                          ),
                                          child: const Text(
                                            'Save',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                fontFamily: 'Montserrat'
                                            ),
                                          ),
                                        )


                                    ),
                                  ),

                                ],
                              ),
                              );
                            }
                            else{
                              return Center(
                                child: Text(
                                  'Something went wrong',
                              ),);
                            }
                          }


                        ),
                      );
               }
                      )
                    ),
                  ),
                )
            ),
      );
  }



  void setInitialData() async {
  _nameController.text=mapData!['name'];
  _emailController.text=mapData!['email'];


  print('name controler ${_nameController.text}');
  print('email controler ${_emailController.text}');
  }


}
