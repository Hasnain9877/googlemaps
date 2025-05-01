import 'package:flutter/material.dart';
import 'package:googlemaps/ui/login_screen.dart';
import 'package:googlemaps/ui/widgets/email_password.dart';
import 'package:googlemaps/ui/widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utills.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController textController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FocusNode textFocus = FocusNode();

  FocusNode passFocus = FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formField = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        title: Text('SignUp'),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formField,
                child: Column(
                  children: [
                    TextEditor(
                      isPassword: false,
                      hintText: 'Email',
                      textEditingController: textController,
                      inputType: TextInputType.text,
                      focusNode: textFocus,
                      suffixIcon: Icon(Icons.email),
                    ),
                    SizedBox(height: 30),
                    TextEditor(
                      isPassword: true,
                      hintText: 'password',
                      textEditingController: passwordController,
                      inputType: TextInputType.text,
                      focusNode: passFocus,
                      suffixIcon: Icon(Icons.password),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              LoginWidget(
                loading: loading,
                onPress: () {
                  if (_formField.currentState!.validate()) {
                    setState(() {
loading = true;
                    });
                    _auth.createUserWithEmailAndPassword(
                      email: textController.text.toString(),
                      password: passwordController.text.toString(),
                    ).then((value){
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace){
                      Utills().toastmessage(error.toString());
                    });
                  }
                },
                width: MediaQuery.of(context).size.width,
                height: 50,
                title: 'SignUp',
              ),
              Row(
                children: [
                  Text('Already have an accout'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
