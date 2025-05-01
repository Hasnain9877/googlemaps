import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  double width, height;
  String title;
bool loading;

  Function()? onPress;

  LoginWidget({
    super.key,
    required this.onPress,
this.loading=false,
    required this.width,
    required this.height,

    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPress,
      child: Container(

        width: width,
        height: height,

        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.blueAccent),

          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child:loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.blue,) : Text(
            title,

          ),
        ),
      ),
    );
  }
}
