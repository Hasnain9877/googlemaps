import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlemaps/posts/post_screen.dart';
import 'package:googlemaps/ui/signup_sreen.dart';
import 'package:googlemaps/ui/widgets/email_password.dart';
import 'package:googlemaps/ui/widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googlemaps/utills.dart';

import '../forgotpassword.dart';
import 'otp/phone.dart';

class LoginScreen extends StatefulWidget {

   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FocusNode textFocus = FocusNode();

  FocusNode passFocus = FocusNode();

  final _formField= GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  bool loading= false;

  void login(BuildContext context){
    setState(() {
      loading= true;
    });
    _auth.signInWithEmailAndPassword(email: textController.text, password: passwordController.text.toString()).then((value){
Utills().toastmessage(value.user!.email.toString());
Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
setState(() {

  loading = false;
});
    }).onError((error, stackTrace){
      Utills().toastmessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Exit the app when back is pressed
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),

        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formField,
                    child: Column(
                      children: [
                        TextEditor(isPassword: false,
                          hintText: 'Email',
                          textEditingController: textController,
                          inputType: TextInputType.text,
                          focusNode: textFocus, suffixIcon: Icon(Icons.email),),
                        SizedBox(height: 30,),
                        TextEditor(isPassword: true,
                          hintText: 'password',
                          textEditingController: passwordController,
                          inputType: TextInputType.text,
                          focusNode: passFocus, suffixIcon: Icon(Icons.password),),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                LoginWidget(
                  loading:loading,

                    onPress: ()
                        {
                          if(_formField.currentState!.validate()){
                            login(context);
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                          }

                        },
                       width: MediaQuery.of(context).size.width,
                        height: 50,
                        title: 'Login',),
                  Row(
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an accout'),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                          child: Text('Signup', style:
                          TextStyle(color: Colors.red, fontWeight: FontWeight.bold),))
                    ],
                  ),
                  SizedBox(height: 30,),
                  LoginWidget(
                    loading:loading,

                    onPress: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneScreen()));

                    },
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    title: 'Login With Phone',),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                  },
                      child: Text('Forgot Password?', style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),))
                  ],
                ),
          ),)
      ),
    );
  }
}
