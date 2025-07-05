import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/teacher/search/widgets/item_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class StudentProfile extends StatelessWidget {
  final StudentModel? studentModel;
  final String? userId;
  StudentProfile({
    super.key,
    this.studentModel,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "student profile".tr(),
          style: getTitleTextStyle(color: AppColors.whiteColor),
        ),
        leading: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: IconButton(
            icon: const Icon(
              Iconsax.arrow_left,
              color: AppColors.whiteColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
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
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('students')
                  .doc(userId)
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
                return Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    children: [
                      Gap(60.sp),
                      CircleAvatar(
                        radius: 80.r,
                        child: CircleAvatar(
                          radius: 90.r,
                          backgroundImage: (studentModel?.data()?['image'] !=
                                          null &&
                                      studentModel!
                                          .data()!['image']
                                          .toString()
                                          .isNotEmpty
                                  ? NetworkImage(studentModel.data()!['image'])
                                  : const AssetImage(AssetsManager.smilingBoy))
                              as ImageProvider,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "information contact".tr(),
                              style: getBodyTextStyle(),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(15.sp),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.primaryColor.withAlpha(50),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TileWidget(
                                      text:
                                          studentModel?.data()?['email'] ?? '',
                                      icon: Iconsax.sms5),
                                  Gap(15.sp),
                                  TileWidget(
                                      text: studentModel?.data()?['phone1'] ??
                                          ''.tr(),
                                      icon: Iconsax.call5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
