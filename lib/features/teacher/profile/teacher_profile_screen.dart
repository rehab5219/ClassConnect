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
                  height: 200,
                  width: double.infinity,
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
                        "teacher profile".tr(),
                        style: getHeadTextStyle()
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 20.w,
                      child: IconButton(
                        icon: Icon(Icons.language,color: AppColors.whiteColor,),
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
                      const Gap(10),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: CircleAvatar(
                              radius: 60,
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
                      const Gap(20),
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
                          const Gap(15),
                          Text(
                            "introduction".tr(),
                            style: getBodyTextStyle(),
                          ),
                          Text(
                            teacherModel!.data()?['bio'] ?? '',
                            style: getSmallTextStyle(),
                          ),
                          const Gap(20),
                          const Divider(),
                          Text(
                            "information contact".tr(),
                            style: getBodyTextStyle(),
                          ),
                          const Gap(5),
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
                                    text: teacherModel.data()?['email'] ?? '',
                                    icon: Icons.email),
                                const Gap(15),
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
