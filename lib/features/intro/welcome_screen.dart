import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/constants/constants.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../auth/presentation/view/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 500.h,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AssetsManager.girlStudent,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(127.r),
                  ),
                ),
                child: Container(
                  height: 650.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyColor.withValues(alpha: 0.5),
                        spreadRadius: 7,
                        blurRadius: 7,
                      ),
                    ],
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(125.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(50.sp),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "easy communication with your child at school".tr(),
                        style: getHeadTextStyle().copyWith(
                            color: AppColors.whiteColor, fontSize: 40.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
           Gap(45.sp),
          Center(
            child: Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black,
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "create an account as".tr(),
                    style: getTitleTextStyle(color: AppColors.primaryColor),
                  ),
                  Gap(40.sp),
                  Column(
                    children: [
                      CustomButton(
                        height: 45.h,
                        width: 220.w,
                        bgColor: AppColors.primaryColor,
                        fgColor: AppColors.whiteColor,
                        text: "teacher".tr(),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(AppConstants.userTypeKey,
                              'teacher'); // Save user type
                          push(
                            context,
                            BlocProvider(
                              create: (context) => AuthCubit(),
                              child: const SignUpScreen(
                                  userType: UserType.teacher),
                            ),
                          );
                        },
                      ),
                       Gap(15.sp),
                      CustomButton(
                        height: 45.h,
                        width: 220.w,
                        bgColor: AppColors.primaryColor,
                        fgColor: AppColors.whiteColor,
                        text: "student".tr(),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(AppConstants.userTypeKey,
                              'student'); // Save user type
                          push(
                            context,
                            BlocProvider(
                              create: (context) => AuthCubit(),
                              child: const SignUpScreen(
                                  userType: UserType.student),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
