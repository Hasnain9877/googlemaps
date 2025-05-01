import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googlemaps/posts/add_post.dart';
import 'package:googlemaps/utills.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../ui/login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  TextEditingController searchController = TextEditingController();
  TextEditingController updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen'),
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPost()));
      }),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(child:
          FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              final title =snapshot.child('title').value.toString();
              if(searchController.text.isEmpty){
                return ListTile(

                  title: Text(snapshot.child('title').value.toString()),
                  trailing: PopupMenuButton(

icon: Icon(Icons.more),
                      itemBuilder: (context)=>[
                    PopupMenuItem(
                        value:1,
                        child: ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showMyDialog(title, snapshot.child('id').value.toString());
                            //Navigator.pop(context);
                          },
                      title: Icon(Icons.edit),
                      leading: Text('Edit'),
                    )),
                        PopupMenuItem(
                            value:2,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                               ref.child(snapshot.child('id').value.toString()).remove();
                                //Navigator.pop(context);
                              },
                              title: Icon(Icons.delete),
                              leading: Text('delete'),
                            ))
                  ]),

                );
              }else if (title.toLowerCase().contains(searchController.text.toLowerCase().toLowerCase())){
                return ListTile(

                  title: Text(snapshot.child('title').value.toString()),
                  trailing: PopupMenuButton(
                      icon: Icon(Icons.more),
                      itemBuilder: (context)=>[
                        PopupMenuItem(child: ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showMyDialog(title, snapshot.child('id').value.toString());
                            // Navigator.pop(context);
                          },
                          title: Icon(Icons.edit),
                          leading: Text('Edit'),
                        )),
                        PopupMenuItem(
                            value:2,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                                //Navigator.pop(context);
                              },
                              title: Icon(Icons.delete),
                              leading: Text('delete'),
                            ))
                      ]),


                );
              }else{
                return Container();
              }



            },
          ),

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













// StreamBuilder(
// stream: ref.onValue,
// builder: (context, AsyncSnapshot<DatabaseEvent> snapShot){
// if(!snapShot.hasData){
// return CircularProgressIndicator();
//
// }else{
// Map<dynamic, dynamic> map= snapShot.data!.snapshot.value as dynamic;
// List<dynamic> list =[];
// list.clear();
// list= map.values.toList();
// return ListView.builder(
// itemCount: snapShot.data!.snapshot.children.length,
// itemBuilder: (context, index){
// return ListTile(
// title: Text(list[index]['title']),
// );
// });
// }
// }
// )