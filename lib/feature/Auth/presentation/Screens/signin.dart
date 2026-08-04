import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/signinbody.dart';
import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  static const routname = "Signin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "تسجيل دخول",
            style: AppStyletext.Bold19,
          ),
        ),
        //  leading: Icon(Icons.arrow_back_ios),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "Signup");
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: Signinbody(),
    );
  }
}
