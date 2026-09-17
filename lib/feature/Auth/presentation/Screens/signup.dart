import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/signupbody.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  static const String routname = "Signup";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        authrepo: get_it<Authrepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "حساب جديد",
              style: AppStyletext.Bold19,
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
      ),
    );
  }
}