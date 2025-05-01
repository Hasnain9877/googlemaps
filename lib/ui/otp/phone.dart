import 'package:flutter/material.dart';
import 'package:googlemaps/utills.dart';

import '../widgets/email_password.dart';
import '../widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'otp_verification.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final textEditingController = TextEditingController();
  FocusNode textFocus = FocusNode();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Login')),
      body: Column(
        children: [
          SizedBox(height: 50),
          TextEditor(
            isPassword: false,
            hintText: '+1 23456 567',
            textEditingController: textEditingController,
            inputType: TextInputType.phone,
            focusNode: textFocus,
            suffixIcon: Icon(Icons.phone),
          ),
          SizedBox(
            height: 30,
          ),
          LoginWidget(onPress: () {
            auth.verifyPhoneNumber(
              phoneNumber: textEditingController.text,
                verificationCompleted: (_){},
                verificationFailed: (e){
                Utills().toastmessage(e.toString());
                },
                codeSent: (String verificationId, int? token){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(verificationId: verificationId,)));
                },
                codeAutoRetrievalTimeout: (e){
                Utills().toastmessage(e.toString());
                });


          },  width: MediaQuery.of(context).size.width,
            height: 50,
            title: 'Verify',),
        ],
      ),
    );
  }
}
