import 'package:ecommerce/cores/utiles/app_assets.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/signin.dart';
import 'package:flutter/material.dart';

class Buttonwidget extends StatelessWidget {
  const Buttonwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Signin.routname);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xffDDDFDF)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.googleicon, width: 20, height: 20),
            const SizedBox(width: 12),
            const Text(
              "تسجيل بواسطة جوجل",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}