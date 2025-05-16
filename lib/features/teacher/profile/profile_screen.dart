import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/auth/models/teacher_model.dart';
import 'package:classconnect/features/teacher/search/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TeacherProfileScreen extends StatefulWidget {
  final TeacherModel? teacherModel;
  const TeacherProfileScreen({
    super.key,
    this.teacherModel,
  });

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
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
                  "TEACHER PROFILE",
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
                const Gap(10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: (widget.teacherModel?.image != null)
                            ? NetworkImage(widget.teacherModel!.image!)
                            : const AssetImage(AssetsManager.smilingBoy),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(5),
                    Text(
                      widget.teacherModel?.specialization ?? '',
                      style: getBodyTextStyle(),
                    ),
                    Text(
                      'Introduction',
                      style: getBodyTextStyle(),
                    ),
                    const Gap(40),
                    const Divider(),
                    Text(
                      widget.teacherModel?.bio ?? '',
                      style: getSmallTextStyle(),
                    ),
                    Text(
                      'Information Contact',
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
                              text: widget.teacherModel?.email ?? '',
                              icon: Icons.email),
                          const Gap(15),
                          TileWidget(
                              text: widget.teacherModel?.phone1 ?? '',
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
