import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/models/subjects_data.dart';
import 'package:classconnect/core/widgets/subjects_name.dart';
import 'package:classconnect/features/teacher/today_lessons/presentation/view/subjects_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';

class TodayLessonsScreen extends StatelessWidget {
  TodayLessonsScreen({super.key});

  final Map<String, List<String>> subjectSubfields = {
    "math": ["STATIC", "DYNAMIC", "ALGEBRA", "GEOMETRY", "CALCULUS"],
    "science": ["PHYSICS", "CHEMISTRY", "BIOLOGY"],
    "social": ["HISTORY", "GEOGRAPHY"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Column(
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
                  Positioned(
                    bottom: 20.h,
                    left: 15.w,
                    child: Text(
                      "today's lessons".tr(),
                      style: getHeadTextStyle()
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    padding: EdgeInsets.all(5.sp),
                    children: [
                      ...List.generate(details.length, (index) {
                        final subject =
                            details[index].subjectsName.toLowerCase();

                        if (subjectSubfields.containsKey(subject)) {
                          return PopupMenuButton<String>(
                            onSelected: (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectsDetails(
                                    subjectName: value,
                                    feedbackType: "Today_Lessons",
                                  ),
                                ),
                              );
                            },
                            itemBuilder: (context) {
                              return subjectSubfields[subject]!
                                  .map((field) => PopupMenuItem(
                                      value: field,
                                      child: Text(
                                        field.tr(),
                                        style: getBodyTextStyle(),
                                      )))
                                  .toList();
                            },
                            child: SubjectsName(details: details[index]),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectsDetails(
                                    subjectName: details[index].subjectsName,
                                    feedbackType: "Today_Lessons",
                                  ),
                                ),
                              );
                            },
                            child: SubjectsName(details: details[index]),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
