import 'dart:io';

import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/constants/specialization_data.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/core/functions/dialogs.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/models/teacher_model.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_cubit.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_state.dart';
import 'package:classconnect/features/student/student_nav_bar/student_nav_bar_screen.dart';
import 'package:classconnect/features/teacher/teacher_nav_bar/teacher-nav_bar_screen.dart';
import 'package:classconnect/service/dio/upload_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class TeacherRegistrationView extends StatefulWidget {
  final UserType userType;
  const TeacherRegistrationView({super.key, required this.userType});

  @override
  _TeacherRegistrationViewState createState() =>
      _TeacherRegistrationViewState();
}

class _TeacherRegistrationViewState extends State<TeacherRegistrationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String _specialization = specialization[0];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;

  Future<void> _getUser() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Image.asset(
                AssetsManager.backpackItems,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
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
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
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
                                color: AppColors.primaryColor
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 25,
                            child: Text(
                              "complete registration process".tr(),
                              style: getTitleTextStyle()
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.sp),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 50.r,
                                    child: CircleAvatar(
                                      radius: 60.r,
                                      backgroundImage: (file != null)
                                          ? FileImage(file!)
                                          : const AssetImage(
                                              AssetsManager.smilingBoy),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await _pickImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 15.r,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        Iconsax.camera,
                                        color: AppColors.primaryColor,
                                        size: 25.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "specialization".tr(),
                                      style: getBodyTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                              // التخصص---------------
                              DropdownButtonFormField(
                                decoration: InputDecoration(
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
                                ),
                                isExpanded: true,
                                iconEnabledColor: AppColors.primaryColor,
                                icon: const Icon(
                                    Iconsax.arrow_circle_down),
                                value: _specialization,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _specialization =
                                        newValue ?? specialization[0].tr();
                                  });
                                },
                                items: specialization.map((element) {
                                  return DropdownMenuItem(
                                    value: element,
                                    child: Text(
                                      element,
                                      style: getSmallTextStyle(),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Gap(10.sp),
                              Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Row(
                                  children: [
                                    Text(
                                      "introduction".tr(),
                                      style: getBodyTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                cursorColor: AppColors.primaryColor,
                                style: getSmallTextStyle(),
                                maxLines: 5,
                                controller: _bio,
                                decoration: InputDecoration(
                                  hintText:
                                      "record general educational information such as your academic education and previous experiences."
                                          .tr(),
                                  hintStyle: getBodyTextStyle()
                                      .copyWith(color: AppColors.whiteColor),
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter your bio".tr();
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.sp),
                                child: Divider(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Row(
                                  children: [
                                    Text(
                                      "phone Number".tr(),
                                      style: getBodyTextStyle(),
                                    )
                                  ],
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                cursorColor: AppColors.primaryColor,
                                style: getSmallTextStyle(),
                                controller: _phone,
                                decoration: InputDecoration(
                                  hintText: "+20xxxxxxxxxx".tr(),
                                  hintStyle: getBodyTextStyle()
                                      .copyWith(color: AppColors.whiteColor),
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter your phone number"
                                        .tr();
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
          // <-- This closes the Stack widget
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(10.sp),
          padding: EdgeInsets.only(top: 25.0.sp),
          child: SizedBox(
            width: double.infinity,
            height: 50.h,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      profileUrl = await uploadImage(file!);
                      context
                          .read<AuthCubit>()
                          .updateTeacherRegistration(TeacherModel(
                            uid: userID,
                            image: profileUrl,
                            phone1: _phone.text,
                            specialization: _specialization,
                            bio: _bio.text,
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.primaryColor,
                          content: Text(
                            "please upload your profile picture".tr(),
                            style: getSmallTextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  text: "registration".tr(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
