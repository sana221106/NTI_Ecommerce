import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:flutter/material.dart';

class Custometextformfeild extends StatefulWidget {
  final String hinttext;
  final bool isPassword;
  final bool isobscureText;
  final TextInputType? textinputType;
  final String? Function(String?) validator;
  final TextEditingController textEditingController;

  const Custometextformfeild({
    super.key,
    required this.hinttext,
    this.textinputType,
    this.isobscureText = false,
    this.isPassword = false,
    required this.validator,
    required this.textEditingController,
  });

  @override
  State<Custometextformfeild> createState() => _CustometextformfeildState();
}

class _CustometextformfeildState extends State<Custometextformfeild> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isobscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.validator,
      keyboardType: widget.textinputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: AppStyletext.Bold13,
        filled: true,
        fillColor: AppColors.graytextfield,


        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grayhinttext,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.grayhinttext),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.greenButton),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.redButton),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.redButton),
        ),
      ),
    );
  }
}
