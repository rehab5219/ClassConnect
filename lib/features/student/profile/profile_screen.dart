import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/teacher/search/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StudentProfileScreen extends StatefulWidget {
  final StudentModel? studentModel;
  const StudentProfileScreen({
    super.key,
    this.studentModel,
  });

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  late StudentModel student;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              // Padding(
              Positioned(
                bottom: 20.h,
                left: 15.w,
                child: Text(
                  "STUDENT PROFILE",
                  style:
                      getHeadTextStyle().copyWith(color: AppColors.whiteColor),
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
                        backgroundImage: (widget.studentModel?.image != null)
                            ? NetworkImage(widget.studentModel!.image!)
                            : const AssetImage(AssetsManager.smilingBoy),
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),
                    Text(
                      'Information Contact',
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
                              text: widget.studentModel?.email ?? '',
                              icon: Icons.email),
                          const Gap(15),
                          TileWidget(
                              text: widget.studentModel?.phone1 ?? '',
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
      ),
    );
  }
}
