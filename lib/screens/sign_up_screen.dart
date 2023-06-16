import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/utils/utils.dart';

import '../controllers/sign_up_controller.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signup Screen'),
          backgroundColor: Colors.yellow,
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ChangeNotifierProvider(
                  create: (_) => SignUpController(),
                  child: Consumer<SignUpController>(
                    builder: (context, provider, child) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  focusNode: _nameFocusNode,
                                  controller: _nameController,
                                  onFieldSubmitted: (value){
                                    utils.fieldFocus(context, _nameFocusNode, _emailFocusNode);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  focusNode: _emailFocusNode,
                                  controller: _emailController,
                                  onFieldSubmitted: (value){
                                    utils.fieldFocus(context, _emailFocusNode, _passwordFocusNode);
                                  },
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
                                TextFormField(
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                  onFieldSubmitted: (value){
                                    utils.fieldFocus(context, _passwordFocusNode, _confirmPasswordFocusNode);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    // Add password strength validation if needed
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  focusNode: _confirmPasswordFocusNode,

                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Form is valid, perform signup logic
                                      // Add your signup implementation here
                                      provider.signUp(context,_nameController.text,_emailController.text,_confirmPasswordController.text);


                                    }
                                  },
                                  child: Text('Sign Up'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
            )));
  }
}
