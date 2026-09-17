import 'package:ecommerce/cores/appvalidator.dart';
import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityreq.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/signin.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/Signupblocconsumer.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/widget/custometextformfeild.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signupbody extends StatefulWidget {
  const Signupbody({super.key});
  static const routname = "signup";

  @override
  State<Signupbody> createState() => _SignupbodyState();
}

class _SignupbodyState extends State<Signupbody> {
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    phoneController.dispose();
  }

  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 20.h),

              Custometextformfeild(
                hinttext: "الاسم كامل",
                textEditingController: nameController,
                validator: AppValidators.validateUsername,
              ),

              SizedBox(height: 16.h),

              Custometextformfeild(
                hinttext: "البريد الإلكتروني",
                textEditingController: emailController,
                validator: AppValidators.validateEmail,
              ),

              SizedBox(height: 16.h),

              Custometextformfeild(
                hinttext: "كلمة المرور",
                textEditingController: passwordController,
                validator: AppValidators.validatePassword,
                isPassword: true,
                isobscureText: true,
              ),

              SizedBox(height: 16.h),

              Custometextformfeild(
                hinttext: "تأكيد كلمة المرور",
                textEditingController: repasswordController,
                validator: (value) {
                  return AppValidators.validateConfirmPassword(
                    value,
                    passwordController.text,
                  );
                },
                isPassword: true,
                isobscureText: true,
              ),

              SizedBox(height: 16.h),

              Custometextformfeild(
                hinttext: "رقم الهاتف",
                textEditingController: phoneController,
                validator: AppValidators.validatePhoneNumber,
              ),

              SizedBox(height: 12.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agree,
                    activeColor: AppColors.greenButton,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                    },
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "من خلال إنشاء حساب، فإنك توافق على ",
                              style: AppStyletext.Bold13,
                            ),
                            TextSpan(
                              text: "الشروط\nوالأحكام الخاصة بنا",
                              style: AppStyletext.Bold13.copyWith(
                                color: AppColors.greenButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Signupblocconsumer(
                onpressed: () {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  if (!agree) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('يجب الموافقة على الشروط والأحكام'),
                      ),
                    );
                    return;
                  }

                  context.read<RegisterCubit>().register(
                    Userentityreq(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      password: passwordController.text,
                      repassword: repasswordController.text,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("تمتلك حساب بالفعل؟ ", style: AppStyletext.SemiBold16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Signin.routname);
                    },
                    child: Text(
                      "تسجيل دخول",
                      style: AppStyletext.SemiBold16.copyWith(
                        color: AppColors.greenButton,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
