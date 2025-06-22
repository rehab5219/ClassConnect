import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/teacher/search/widgets/item_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('students')
              .doc(userId)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var studentModel = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Gap(60),
                  CircleAvatar(
                    radius: 80,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage:
                          (studentModel?.data()?['image'] != null &&
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
                        const SizedBox(
                          height: 10,
                        ),
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
                                  text: studentModel?.data()?['phone1'] ?? ''.tr(),
                                  icon: Icons.call),
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
    );
  }
}
