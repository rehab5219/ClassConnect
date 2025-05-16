import 'package:classconnect/core/models/subjects_data.dart';
import 'package:classconnect/core/widgets/subjects_name.dart';
import 'package:classconnect/features/student/home/presentation/view/receive_feedback.dart';
import 'package:classconnect/features/teacher/today_lessons/presentation/view/subjects_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class TodayLessonsScreen extends StatelessWidget {
  const TodayLessonsScreen({super.key});

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
                  "TODAY'S LESSONS",
                  style:
                      getHeadTextStyle().copyWith(color: AppColors.whiteColor),
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
                                // builder: (context) => SubjectsDetails(
                                //   subject: details[index],
                                  builder: (context) => ReceiveFeedback(),
                                // ),
                              ),
                            );
                          },
                          child: SubjectsName(details: details[index]),
                        );
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
