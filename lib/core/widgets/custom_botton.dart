import 'package:classconnect/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.height,
    this.width,
    this.fgColor,
    this.borderColor,
    this.radius = 15,
  });

  final String text;
  final Function() onPressed;
  final Color? bgColor;
  final Color? fgColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? AppColors.primaryColor,
          side: borderColor != null
              ? BorderSide(color: borderColor ?? AppColors.primaryColor)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 80.w,
          ),
          elevation: 7,
        ),
        child: Text(
          text,
          style: getBodyTextStyle(color: fgColor ?? AppColors.whiteColor),
        ),
      ),
    );
  }
}