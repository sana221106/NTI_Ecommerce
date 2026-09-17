import 'package:ecommerce/cores/appvalidator.dart';
import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/cores/widgets/buttonwidget.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentitysigninreq.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/forgetpass.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/custometextformfeild.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/signup.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/signinblocconsumer.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signinbody extends StatefulWidget {
  const Signinbody({super.key});

  @override
  State<Signinbody> createState() => _SinginBodyState();
}

class _SinginBodyState extends State<Signinbody> {
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  var formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custometextformfeild(
                validator: AppValidators.validateEmail,
                textEditingController: emailController,
                hinttext: "البريد الالكتروني",
              ),
              SizedBox(height: 10.h),

              Custometextformfeild(
                validator: AppValidators.validatePassword,
                textEditingController: passwordController,
                isPassword: true,
                isobscureText: true,
                hinttext: "كلمه المرور",
              ),
              SizedBox(height: 15.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, forgetpass.routname);
                    },
                    child: Text(
                      'نسيت كلمه المرور؟',
                      textAlign: TextAlign.start,
                      style: AppStyletext.SemiBold13.copyWith(
                        color: AppColors.greenButton,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Signinblocconsumer(
                onpressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<SigninCubit>().signin(
                      Userentitysigninreq(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("لا تمتلك حساب؟ ", style: AppStyletext.SemiBold16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Signup.routname);
                    },
                    child: Text(
                      "قم بإنشاء حساب",
                      style: AppStyletext.SemiBold16.copyWith(
                        color: AppColors.greentext,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(indent: 20, endIndent: 20, thickness: 2),
                  ),
                  Text("او"),

                  Expanded(
                    child: Divider(indent: 20, endIndent: 20, thickness: 2),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Buttonwidget(),
            ],
          ),
        ),
      ),
    );
  }
}
