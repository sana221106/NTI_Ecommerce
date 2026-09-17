import 'package:ecommerce/cores/widgets/CustomButton.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/buildSnacBar.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signupblocconsumer extends StatelessWidget {
  final void Function() onpressed;

  const Signupblocconsumer({super.key, required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          BuildSnakBar(
            context,
            "تم انشاء حساب بنجاح",
            type: SnackbarType.success,
          );
          Navigator.pop(context);
        }
        if (state is RegisterFailure) {
          BuildSnakBar(context, state.errmessege, type: SnackbarType.error);
        }
      },
      builder: (context, state) {
        bool isLoading = state is RegisterLoading;
        return isLoading?Center(child: CircularProgressIndicator()):CustomButton(
                title: "إنشاء حساب جديد",
                onPressed: onpressed,
                    );
      },
    );
  }
}
