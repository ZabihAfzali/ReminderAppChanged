import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controllers/forgot_password_controller.dart';
import 'package:reminder_app/utils/utils.dart';

import '../controllers/sign_up_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Password Reset'),
          backgroundColor: Colors.yellow,
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Enter the code that has been sent to your email address'),
                              SizedBox(height: 10,),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey[200]!),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
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
                              ChangeNotifierProvider(
                              create: (_) => ForgotPasswordController(),
                              child: Consumer<ForgotPasswordController>(
                              builder: (context, provider, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Form is valid, perform signup logic
                                    // Add your signup implementation here
                                    provider.forgotPassword(context,_emailController.text);


                                  }
                                },
                                child: Text('Submit'),
                              );
                              },
                              ),
                              )
                            ]

                          ),
                        ),
                      ),
                  ),
                );
  }
}
