import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googlemaps/posts/post_screen.dart';

import '../../utills.dart';
import '../widgets/email_password.dart';
import '../widgets/login_widget.dart';

class OtpVerification extends StatefulWidget {
  final String verificationId;
   OtpVerification({super.key, required this.verificationId});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final textEditingController = TextEditingController();
  //final textEditingController = TextEditingController();
  FocusNode textFocus = FocusNode();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          SizedBox(height: 50),
          TextEditor(
            isPassword: false,
            hintText: '',
            textEditingController: textEditingController,
            inputType: TextInputType.phone,
            focusNode: textFocus,
            suffixIcon: Icon(Icons.phone),
          ),
          SizedBox(
            height: 30,
          ),
          LoginWidget(onPress: () {
            final credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: textEditingController.text.toString());

try{
  auth.signInWithCredential(credential);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));

}catch(e){
  Utills().toastmessage(e.toString());
}

          },  width: MediaQuery.of(context).size.width,
            height: 50,
            title: 'Verify',),
        ],
      ),
    );
  }
}
