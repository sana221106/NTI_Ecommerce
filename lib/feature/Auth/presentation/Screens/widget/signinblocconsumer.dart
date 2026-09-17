import 'package:ecommerce/cores/widgets/CustomButton.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/buildSnacBar.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/signin_cubit.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/signin_state.dart';
import 'package:ecommerce/feature/main/presentation/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signinblocconsumer extends StatelessWidget {
  final void Function() onpressed;

  const Signinblocconsumer({super.key, required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          BuildSnakBar(
            context,
            "تم تسجيل الدخول بنجاح",
            type: SnackbarType.success,
          );
          Navigator.pushNamed(context, Mainscreen.routname);
        }
        if (state is SigninFailure) {
          BuildSnakBar(context, state.errmessege, type: SnackbarType.error);
        }
      },
      builder: (context, state) {
        bool isLoading = state is SigninLoading;
        return isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomButton(title: "تسجيل دخول", onPressed: onpressed);
      },
    );
  }
}
