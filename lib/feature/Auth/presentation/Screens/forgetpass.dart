import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/forgetpassbody.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/forgetpassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class forgetpass extends StatelessWidget {
  const forgetpass({super.key});

  static const String routname = "forgetpass";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => forgetpassCubit(
          authrepo: get_it<Authrepo>(),
        ),
        child: Forgetpassbody(),
      ),
    );
  }
}