import 'package:flutter/material.dart';

import '../ui/widgets/email_password.dart';
import '../ui/widgets/login_widget.dart';
import 'package:firebase_database/firebase_database.dart';

import '../utills.dart';

class AddPost extends StatefulWidget {
 // final textEditingController = TextEditingController();
   AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final databaseRefrence = FirebaseDatabase.instance.ref("Post");
  FocusNode textFocus = FocusNode();
TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          TextEditor(isPassword: false, hintText: '', textEditingController: textEditingController, inputType: TextInputType.text, focusNode: textFocus, suffixIcon: Icon(Icons.add),),

          SizedBox(height: 50,),
          LoginWidget(onPress: () {
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            databaseRefrence.child(id).set({
              "title": textEditingController.text.toString(),
              "id": id
            }).then((value){
              Utills().toastmessage('Post Added');
            }).onError((error, StackTrace){
Utills().toastmessage(error.toString());
            });



          }, width: MediaQuery.of(context).size.width,
            height: 50,
            title: 'Add Post',),
        ],
      ),
    );
  }


}
