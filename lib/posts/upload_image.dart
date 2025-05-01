


import 'dart:io';

import 'package:flutter/material.dart';

import '../ui/widgets/login_widget.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final picker = ImagePicker();


  Future getImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: (){
                getImage();
              },
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
                ),
                child:_image != null ? Image.file(_image!.absolute) : Icon(Icons.image),
              ),
            ),
          ),
          SizedBox(height: 20,),
          LoginWidget(onPress: () {


          }, width: 200, height: 50, title: 'Upload',)
        ],
      ),
    );
  }
}
