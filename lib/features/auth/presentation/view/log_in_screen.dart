import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/core/functions/dialogs.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/presentation/view/sign_up_screen.dart';
import 'package:classconnect/features/student/student_nav_bar/student_nav_bar_screen.dart';
import 'package:classconnect/features/teacher/teacher_nav_bar/teacher-nav_bar_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class LogInScreen extends StatefulWidget {
  final UserType userType;

  const LogInScreen({super.key, required this.userType});

  @override
  State<LogInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserType.teacher ? 'teacher' : 'student';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              Navigator.pop(context);
              showErrorDialog(context, "something went wrong".tr());
            } else if (state is AuthLoadingState) {
              showLoadingDialog(context);
            } else if (state is AuthSuccessState) {
              if (widget.userType == UserType.teacher) {
                pushAndRemoveUntil(context, const TeacherNavBarScreen());
              } else {
                pushAndRemoveUntil(context, const StudentNavBarScreen());
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                AssetsManager.girlStudent,
                              ),
                            ),
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(80.r),
                            ),
                          ),
                          child: Container(
                            height: 200.h,
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor
                                      .withValues(alpha: 0.5),
                                  spreadRadius: 8,
                                  blurRadius: 8,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(80.r),
                              ),
                              color:
                                  AppColors.primaryColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.h,
                          left: 25.w,
                          child: Text(
                            "welcome back".tr(),
                            style: getHeadTextStyle()
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),
                     Gap(80.sp),
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: TextFormField(
                        controller: email,
                        style: getSmallTextStyle(),
                        decoration: InputDecoration(
                          hintText: "email".tr(),
                          hintStyle: getBodyTextStyle()
                              .copyWith(color: AppColors.greyColor),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.redColor,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please, enter your email".tr();
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                              .hasMatch(value)) {
                            return "please, enter valid email".tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Gap(5.sp),
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: TextFormField(
                        controller: password,
                        style: getSmallTextStyle(),
                        decoration: InputDecoration(
                          hintText: "password".tr(),
                          hintStyle: getBodyTextStyle()
                              .copyWith(color: AppColors.greyColor),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(
                              (isVisible)
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.redColor,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        obscureText: isVisible,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please, enter your password".tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Gap(20.sp),
                    CustomButton(
                        height: 45.h,
                        width: 300.w,
                        bgColor: AppColors.primaryColor,
                        fgColor: AppColors.whiteColor,
                        text: "logIn".tr(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              context.read<AuthCubit>().login(
                                    email: email.text,
                                    password: password.text,
                                  );
                            });
                            if (widget.userType == UserType.teacher) {
                              push(
                                context,
                                const TeacherNavBarScreen(),
                              );
                            } else {
                              push(
                                context,
                                const StudentNavBarScreen(),
                              );
                            }
                          }
                        }),
                    Gap(20.sp),
                    Padding(
                      padding: EdgeInsets.only(top: 30.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "don\'t have an account?".tr(),
                            style:
                                getSmallTextStyle(color: AppColors.greyColor),
                          ),
                          TextButton(
                              onPressed: () {
                                pushReplacement(
                                  context,
                                  SignUpScreen(userType: widget.userType),
                                );
                              },
                              child: Text(
                                "sign Up".tr(),
                                style: getSmallTextStyle(
                                    color: AppColors.primaryColor),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
