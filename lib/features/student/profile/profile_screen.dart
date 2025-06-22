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
                  height: 200,
                  width: double.infinity,
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/girl-student-with-clapping-teacher.jpg",
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
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 6,
                              blurRadius: 6,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(80.r),
                          ),
                          color: Colors.blue.withValues(alpha: 0.6),
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
                        "student profile".tr(),
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Gap(30),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: CircleAvatar(
                              radius: 60,
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
                              radius: 15,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '${studentModel?.data()?['firstName'] ?? ''} ${studentModel?.data()?['secondName'] ?? ''}',
                              style: getBodyTextStyle(),
                            ),
                          ),
                          const Gap(50),
                          Text(
                            "information contact".tr(),
                            style: getBodyTextStyle(),
                          ),
                          const Gap(10),
                          Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor.withAlpha(50),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TileWidget(
                                    text: studentModel?.data()?['email'] ?? '',
                                    icon: Icons.email),
                                const Gap(15),
                                TileWidget(
                                    text: studentModel?.data()?['phone1'] ?? '',
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
