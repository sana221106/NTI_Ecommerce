import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFF1F1F1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 55,
            child: IconButton(
              onPressed: () {
                // Filter button
              },
              icon: const Icon(
                Icons.tune,
                size: 22,
                color: AppColors.grayhinttext,
              ),
            ),
          ),

          Container(
            height: 28,
            width: 1,
            color: AppColors.graytextfield,
          ),

          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,

              onChanged: onChanged,

              decoration: InputDecoration(
                hintText: 'إبحث عن......',
                hintStyle: AppStyletext.normal14,
                suffixIcon: const Icon(
                  Icons.search,
                  size: 27,
                  color: AppColors.greenButton,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}