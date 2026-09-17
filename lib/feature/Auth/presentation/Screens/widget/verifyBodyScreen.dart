import 'package:ecommerce/feature/Auth/presentation/Screens/widget/verifyblocconsumer.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class verifybodyscreen extends StatefulWidget {
  const verifybodyscreen({super.key});

  @override
  State<verifybodyscreen> createState() => _verifybodyscreenState();
}

class _verifybodyscreenState extends State<verifybodyscreen> {
  var formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController otpcpntroller = TextEditingController();

  @override
  void dispose() {
    otpcpntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: MaterialPinField(
                  length: 6,
                  keyboardType: TextInputType.number,

                  onChanged: (value) {
                    otpcpntroller.text = value;
                  },

                  onCompleted: (pin) {
                    otpcpntroller.text = pin;
                  },

                  theme: MaterialPinTheme(
                    shape: MaterialPinShape.filled,
                    cellSize: Size(45.w, 50.h),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Verifyblocconsumer(
                onpressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<verifyCubit>().verify(
                      code: otpcpntroller.text,
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
