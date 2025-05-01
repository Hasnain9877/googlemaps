import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../posts/add_post.dart';
import '../ui/login_screen.dart';
import '../utills.dart';
import 'add_data.dart';

class FireStoreListScreen extends StatefulWidget {
  const FireStoreListScreen({super.key});

  @override
  State<FireStoreListScreen> createState() => _FireStoreListScreenState();
}

class _FireStoreListScreenState extends State<FireStoreListScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  TextEditingController searchController = TextEditingController();
  TextEditingController updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FireStore Screen'),
          actions: [
            IconButton(onPressed: (){
              auth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }).onError((error, stackTrace){
                // Utills().toastmessage(error.toString())
                Utills().toastmessage(error.toString());
              });
            }, icon: Icon(Icons.logout_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData()));
            }),
        body: Column(
          children: [
            SizedBox(height: 20,),

            Expanded(child:
          ListView.builder(

              itemBuilder: (context, index){
ListTile(
  title: Text('hasnain'),
);
              })

            )
          ],
        )
    );

  }
  Future<void> showMyDialog(String title, String id) async{
    updateController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: updateController,
                decoration: InputDecoration(
                    hintText: 'Update'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);

              }, child: Text('Cancle')),
              TextButton(onPressed: (){
                ref.child(id).update({
                  'title': updateController.text.toString()
                }).then((onValue){
                  Utills().toastmessage('Post Updated');
                }).onError((error, stackTrace){
                  Utills().toastmessage(error.toString());
                });
                Navigator.pop(context);
              }, child: Text('Update')),
            ],
          );
        });
  }
}
