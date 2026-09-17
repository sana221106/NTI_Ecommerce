import 'package:ecommerce/cores/widgets/CustomButton.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/verifyScreen.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/buildSnacBar.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/forgetpassword_cubit.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/forgetpassword_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class forgetpassblocconsumer extends StatelessWidget {
  final void Function() onpressed;

  const forgetpassblocconsumer({super.key, required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<forgetpassCubit, forgetpassState>(
      listener: (context, state) {
        if (state is forgetpassSuccess) {
          BuildSnakBar(
            context,
            state.message,
            type: SnackbarType.success,
          );
         Navigator.pushNamed(context, verifyscreen.routname);
        }
        if (state is forgetpassFailure) {
          BuildSnakBar(context, state.errmessege, type: SnackbarType.error);
        }
      },
      builder: (context, state) {
        bool isLoading = state is forgetpassLoading ;
        return isLoading?Center(child: CircularProgressIndicator()):CustomButton(
                title: "إرسال الكود",
                onPressed: onpressed,
                    );
      },
    );
  }
}
