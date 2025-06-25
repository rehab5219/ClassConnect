import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 27.h,
            width: 27.w,
            color: AppColors.primaryColor,
            child: Icon(
              icon,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        ),
         SizedBox(
          width: 10.w,
        ),
        Expanded(child: Text(text, style: getBodyTextStyle())),
      ],
    );
  }
}