import 'package:classconnect/core/models/week_lessons_data.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final WeekLessonsData weekList;
  final TextEditingController? controller; 
  const WeekTextFormField(
      {super.key, this.keyboardType, this.validator, this.onTap, required this.weekList,  this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // minLines:1,
      maxLines: 10,
      controller: controller,
      style: getSmallTextStyle().copyWith(color: AppColors.whiteColor),
      onTap: onTap,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(
            weekList.weekName,
          style: getSmallTextStyle().copyWith(color: AppColors.whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.greyColor,
            // width: 2
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.whiteColor,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
