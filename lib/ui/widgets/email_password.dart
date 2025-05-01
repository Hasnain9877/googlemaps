import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late TextInputType inputType;

  final String hintText;
  final bool isPassword;
  final Icon suffixIcon;

  TextEditor({
    super.key,
    required this.isPassword,
    required this.hintText,

    required this.textEditingController,
    required this.inputType,
    required this.focusNode, required this.suffixIcon,
  });

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  @override
  Widget build(BuildContext context) {
    bool _isObscured = true;
    return TextFormField(

        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        focusNode: widget.focusNode,
       obscureText: widget.isPassword ? _isObscured : false,

        decoration: InputDecoration(
          hintText: widget.hintText,
prefixIcon: widget.suffixIcon,
          suffixIcon: widget.isPassword ? IconButton(onPressed: (){
            setState(){
              _isObscured= !_isObscured;
            }
          },
              icon: Icon(_isObscured? Icons.visibility_off : Icons.visibility)): null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.yellow,
              width: 3.0,
              //style: BorderStyle.solid,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.yellow, width: 2), // Non-focused border
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 3), // Focused border
          ),
        ),
      validator: (value){
          if(value!.isEmpty){
            if(widget.isPassword){
              return "Enter Password";
            }else{
              return "Enter Email";
            }
          }else {
            return null;
          }
      },
      );

  }
}
