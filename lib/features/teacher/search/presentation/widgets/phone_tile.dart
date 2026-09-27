
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconTile extends StatelessWidget {
  final IconData imgAssetPath;
  final Color backColor;
  final void Function()? onTap;
  final String num;
  const IconTile(
      {super.key,
      required this.imgAssetPath,
      required this.backColor,
      this.onTap,
      required this.num});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 16.w),
        height: 45.h,
        width: 45.w,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(num),
            Icon(
              imgAssetPath,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
