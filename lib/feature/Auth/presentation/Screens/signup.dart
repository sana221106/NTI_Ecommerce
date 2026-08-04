import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/signupbody.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  static const String routname = "Signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "حساب جديد",
            style: AppStyletext.Bold19
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: const Signupbody(),
    );
  }
}