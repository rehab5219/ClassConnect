import 'package:classconnect/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle getHeadTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color,
    fontSize: fontSize ?? 30.sp,
  );
}

TextStyle getTitleTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color,
    fontSize: fontSize ?? 25.sp,
  );
}

TextStyle getBodyTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color,
    fontSize: fontSize ?? 18.sp,
  );
}

TextStyle getSmallTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color,
    fontSize: fontSize ?? 16.sp,
  );
}
