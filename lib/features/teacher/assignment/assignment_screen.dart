import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/subjects_data.dart';
import '../../../../core/widgets/subjects_name.dart';
import '../today_lessons/presentation/view/subjects_details.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

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
                  "assignments".tr(),
                  style: getHeadTextStyle().copyWith(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  padding: EdgeInsets.all(5.w),
                  children: [
                    ...List.generate(
                      details.length,
                          (index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectsDetails(
                                  subjectName: details[index].subjectsName,
                                  feedbackType: "Assignment",
                                ),
                              ),
                            );
                          },
                          child: SubjectsName(details: details[index]),);
                      },
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
