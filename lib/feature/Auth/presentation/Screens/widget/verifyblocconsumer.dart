import 'package:ecommerce/cores/widgets/CustomButton.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/buildSnacBar.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/verify_cubit.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/verify_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Verifyblocconsumer extends StatelessWidget {
  final void Function() onpressed;

  const Verifyblocconsumer({super.key, required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<verifyCubit, verifyState>(
      listener: (context, state) {
        if (state is verifySuccess) {
          BuildSnakBar(
            context,
            "تم التحقق من البريد الإلكتروني  بنجاح",
            type: SnackbarType.success,
          );
          Navigator.pop(context);
        }
        if (state is verifyFailure) {
          BuildSnakBar(context, state.errmessege, type: SnackbarType.error);
        }
      },
      builder: (context, state) {
        bool isLoading = state is verifyLoading;
        return isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomButton(title: "تحقق من الرمز", onPressed: onpressed);
      },
    );
  }
}
