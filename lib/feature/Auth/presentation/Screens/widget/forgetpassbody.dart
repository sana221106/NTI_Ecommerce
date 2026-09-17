
import 'package:ecommerce/cores/appvalidator.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/custometextformfeild.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/forgetpassblocconsumer.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/forgetpassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Forgetpassbody extends StatefulWidget {
  const Forgetpassbody({super.key});

  @override
  State<Forgetpassbody> createState() => _ForgetpassbodyState();
}

class _ForgetpassbodyState extends State<Forgetpassbody> {
  var formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;

  TextEditingController forgetpasscpntroller =
      TextEditingController();

  @override
  void dispose() {
    forgetpasscpntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              Custometextformfeild(
                validator: AppValidators.validateEmail,
                textEditingController: forgetpasscpntroller,
                hinttext: "البريد الالكتروني",),
                SizedBox(height: 15.h,),
                forgetpassblocconsumer(
                    onpressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<forgetpassCubit>().forgetpass(email: forgetpasscpntroller.text,
                        );
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                  ),
               ],
          ),
        ),
      ),
    );
  }
}