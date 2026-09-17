import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/signinbody.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signin extends StatelessWidget {
  static const routname = "Signin";

  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        authrepo: get_it<Authrepo>(),
      ),
      child: Scaffold(
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
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "Signup");
              },
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
        body: Signinbody(),
      ),
    );
  }
}