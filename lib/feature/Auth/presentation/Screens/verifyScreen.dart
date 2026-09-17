import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/verifyBodyScreen.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class verifyscreen extends StatelessWidget {
  const verifyscreen({super.key});

  static const String routname = "verifyscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => verifyCubit(
          authrepo: get_it<Authrepo>(),
        ),
        child: verifybodyscreen(),
      ),
    );
  }
}