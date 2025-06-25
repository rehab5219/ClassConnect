import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/core/functions/dialogs.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/presentation/view/log_in_screen.dart';
import 'package:classconnect/features/auth/presentation/view/student_registeration_view.dart';
import 'package:classconnect/features/auth/presentation/view/teacher_registeration_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  final UserType userType;

  const SignUpScreen({super.key, required this.userType});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
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
                pushAndRemoveUntil(context,
                    TeacherRegistrationView(userType: widget.userType));
              } else {
                pushAndRemoveUntil(context,
                    StudentRegistrationView(userType: widget.userType));
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
                          height: 200.h,
                          width: double.infinity.w,
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
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor
                                      .withValues(alpha: 0.5),
                                  spreadRadius: 6,
                                  blurRadius: 6,
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
                            "sign up to Classconnect".tr(),
                            style: getTitleTextStyle()
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),
                     Gap(20.sp),
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: TextFormField(
                        controller: firstName,
                        style: getSmallTextStyle(),
                        decoration: InputDecoration(
                          hintText: "first name".tr(),
                          hintStyle: getBodyTextStyle()
                              .copyWith(color: AppColors.greyColor),
                          prefixIcon: const Icon(Icons.person,
                              color: AppColors.primaryColor),
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
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please, enter your first name".tr();
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
                        controller: secondName,
                        style: getSmallTextStyle(),
                        decoration: InputDecoration(
                          hintText: "second name".tr(),
                          hintStyle: getBodyTextStyle()
                              .copyWith(color: AppColors.greyColor),
                          prefixIcon: const Icon(
                            Icons.person,
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
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please, enter your second name".tr();
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
                            borderRadius: BorderRadius.circular(20.r),
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
                        width: 250.w,
                        bgColor: AppColors.primaryColor,
                        fgColor: AppColors.whiteColor,
                        text: "sign Up".tr(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              context.read<AuthCubit>().register(
                                  firstName: firstName.text,
                                  secondName: secondName.text,
                                  email: email.text,
                                  password: password.text,
                                  userType: widget.userType);
                            });
                          }
                        }),
                     Gap(20.sp),
                    Padding(
                      padding: EdgeInsets.only(top: 30.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "i have an account?".tr(),
                            style:
                                getSmallTextStyle(color: AppColors.greyColor),
                          ),
                          TextButton(
                              onPressed: () {
                                pushReplacement(
                                  context,
                                  LogInScreen(userType: widget.userType),
                                );
                              },
                              child: Text(
                                "logIn".tr(),
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
