


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/posts/post_screen.dart';
import 'package:googlemaps/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firestore/fire_store_list_screen.dart';
import '../posts/upload_image.dart';

class SplashServices {


  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 1), ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen())
          ));
    }else{
      Timer(Duration(seconds: 1), ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())
          ));
    }

  }
}