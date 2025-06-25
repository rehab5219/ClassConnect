import 'dart:io';

import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/intro/welcome_screen.dart';
import 'package:classconnect/features/teacher/search/widgets/item_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({
    super.key,
  });

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
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
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('teachers')
              .doc(userID)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Lottie.asset(
                  'assets/icons/Classroom.json',
                  height: 200.h,
                  width: double.infinity.w,
                  fit: BoxFit.contain,
                ),
              );
            }

            var teacherModel = snapshot.data;
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AssetsManager.girlStudent,
                          ),
                        ),
                        color: Colors.blue,
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
                              color: AppColors.greyColor.withValues(alpha: 0.5),
                              spreadRadius: 6,
                              blurRadius: 6,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(80.r),
                          ),
                          color: AppColors.primaryColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 130.h,
                      start: 300.w,
                      child: IconButton(
                        onPressed: () {
                          _signOut();
                          pushAndRemoveUntil(context, const WelcomeScreen());
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 15.w,
                      child: Text(
                        "teacher profile".tr(),
                        style: getHeadTextStyle()
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 20.w,
                      child: IconButton(
                        icon: Icon(
                          Icons.language,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () {
                          final currentLocale = context.locale;
                          final newLocale = currentLocale.languageCode == 'en'
                              ? Locale('ar')
                              : Locale('en');
                          context.setLocale(newLocale);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    children: [
                      Gap(10.sp),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundImage: (_imagePath != null)
                                  ? FileImage(File(_imagePath!))
                                  : (teacherModel?.data()?['image'] != null &&
                                              teacherModel!
                                                  .data()!['image']
                                                  .toString()
                                                  .isNotEmpty
                                          ? NetworkImage(
                                              teacherModel.data()!['image'])
                                          : const AssetImage(
                                              AssetsManager.smilingBoy))
                                      as ImageProvider,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _pickImage();
                            },
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.sp),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '${teacherModel?.data()?['firstName'] ?? ''} ${teacherModel?.data()?['secondName'] ?? ''}',
                              style: getBodyTextStyle(),
                            ),
                          ),
                          Center(
                            child: Text(
                              teacherModel
                                      ?.data()?['specialization']
                                      ?.toString() ??
                                  '',
                              style: getBodyTextStyle(),
                            ),
                          ),
                          Gap(15.sp),
                          Text(
                            "introduction".tr(),
                            style: getBodyTextStyle(),
                          ),
                          Text(
                            teacherModel!.data()?['bio'] ?? '',
                            style: getSmallTextStyle(),
                          ),
                           Gap(20.sp),
                          const Divider(),
                          Text(
                            "information contact".tr(),
                            style: getBodyTextStyle(),
                          ),
                           Gap(5.sp),
                          Container(
                            padding: EdgeInsets.all(15.sp),
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.primaryColor.withAlpha(50),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TileWidget(
                                    text: teacherModel.data()?['email'] ?? '',
                                    icon: Icons.email),
                                 Gap(15.sp),
                                TileWidget(
                                    text: teacherModel.data()?['phone1'] ?? '',
                                    icon: Icons.call),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
