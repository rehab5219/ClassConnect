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
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({
    super.key,
  });

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('uid');
      await prefs.remove('email');
      await prefs.remove('userType');
      await prefs.remove('isLoggedIn');
      await prefs.remove('hasSeenWelcome');
    } catch (e) {
      print('Error signing out: $e');
    }
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
              .collection('students')
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
            var studentModel = snapshot.data;
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
                      bottom: 120.h,
                      start: 300.w,
                      child: IconButton(
                        onPressed: () {
                          _signOut();
                          pushAndRemoveUntil(context, const WelcomeScreen());
                        },
                        icon: const Icon(
                          Iconsax.logout,
                          color: AppColors.whiteColor,
                          size: 30,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 15.w,
                      child: Text(
                        "student profile".tr(),
                        style: getHeadTextStyle()
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 30.w,
                      child: IconButton(
                        icon: Icon(
                          Iconsax.language_square,
                          color: AppColors.whiteColor,
                          size: 35,
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
                      Gap(30.sp),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundImage: (_imagePath != null)
                                  ? FileImage(File(_imagePath!))
                                  : (studentModel?.data()?['image'] != null &&
                                              studentModel!
                                                  .data()!['image']
                                                  .toString()
                                                  .isNotEmpty
                                          ? NetworkImage(
                                              studentModel.data()!['image'])
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
                                Iconsax.camera,
                                size: 25.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(30.sp),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '${studentModel?.data()?['firstName'] ?? ''} ${studentModel?.data()?['secondName'] ?? ''}',
                              style: getBodyTextStyle(),
                            ),
                          ),
                          Gap(50.sp),
                          Text(
                            "information contact".tr(),
                            style: getBodyTextStyle(),
                          ),
                          Gap(10.sp),
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
                                    text: studentModel?.data()?['email'] ?? '',
                                    icon: Iconsax.sms5),
                                Gap(15.sp),
                                TileWidget(
                                    text: studentModel?.data()?['phone1'] ?? '',
                                    icon: Iconsax.call5),
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
