import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/models/subjects_data.dart';
import 'package:classconnect/core/widgets/subjects_name.dart';
import 'package:classconnect/features/student/today_lessons/receive_feedback.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class TodayLessonsScreen extends StatefulWidget {
  TodayLessonsScreen({super.key});

  @override
  _TodayLessonsScreenState createState() => _TodayLessonsScreenState();
}

class _TodayLessonsScreenState extends State<TodayLessonsScreen> {
  final Map<String, List<String>> subjectSubfields = {
    "math": ["STATIC", "DYNAMIC", "ALGEBRA", "GEOMETRY", "CALCULUS"],
    "science": ["PHYSICS", "CHEMISTRY", "BIOLOGY"],
    "social": ["HISTORY", "GEOGRAPHY"],
  };

  final List<String> stages = [
    'All',
    'Primary 1',
    'Primary 2',
    'Primary 3',
    'Primary 4',
    'Primary 5',
    'Primary 6',
    'Prep 1',
    'Prep 2',
    'Prep 3',
    'Secondary 1',
    'Secondary 2',
    'Secondary 3',
  ];

  final Map<String, List<String>> stageSubjects = {
    'Primary 1': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'FRENCH' , 'GERMAN'],
    'Primary 2': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'FRENCH' , 'GERMAN'],
    'Primary 3': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'FRENCH' , 'GERMAN'],
    'Primary 4': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'FRENCH' , 'GERMAN'],
    'Primary 5': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'FRENCH' , 'GERMAN'],
    'Primary 6': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'FRENCH' , 'GERMAN'],
    'Prep 1': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'SOCIAL', 'FRENCH', 'GERMAN'],
    'Prep 2': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'SOCIAL', 'FRENCH', 'GERMAN'],
    'Prep 3': ['ARABIC', 'MATH', 'SCIENCE', 'ENGLISH', 'RELIGION', 'SOCIAL', 'FRENCH', 'GERMAN'],
    'Secondary 1': [
      'ARABIC',
      'MATH',
      'SCIENCE',
      'ENGLISH',
      'RELIGION',
      'SOCIAL',
      'FRENCH',
      'GERMAN',
      'PHILOSOPHY',
      'PSYCHOLOGY'
    ],
    'Secondary 2': [
      'ARABIC',
      'MATH',
      'SCIENCE',
      'ENGLISH',
      'RELIGION',
      'SOCIAL',
      'FRENCH',
      'GERMAN',
      'PHILOSOPHY',
      'PSYCHOLOGY'
    ],
    'Secondary 3': [
      'ARABIC',
      'MATH',
      'SCIENCE',
      'ENGLISH',
      'RELIGION',
      'SOCIAL',
      'FRENCH',
      'GERMAN',
      'PHILOSOPHY',
      'PSYCHOLOGY'
    ],
  };

  String selectedStage = 'All';

  List<SubjectsData> getFilteredSubjects() {
    if (selectedStage == 'All') {
      return details;
    }
    return details.where((subject) {
      return stageSubjects[selectedStage]!
          .contains(subject.subjectsName.toUpperCase());
    }).toList();
  }

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
                    width: double.infinity,
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
                  Positioned(
                    bottom: 20.h,
                    left: 15.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "today's lessons".tr(),
                          style: getHeadTextStyle()
                              .copyWith(color: AppColors.whiteColor),
                        ),
                        SizedBox(width: 10.w),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            setState(() {
                              selectedStage = value;
                            });
                          },
                          itemBuilder: (context) {
                            return stages.map((stage) {
                              return PopupMenuItem<String>(
                                value: stage,
                                child: Text(
                                  stage.tr(),
                                  style: getBodyTextStyle(),
                                ),
                              );
                            }).toList();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor.withAlpha(40),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "select stage".tr(),
                                  style: getBodyTextStyle().copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.primaryColor,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                      ...List.generate(getFilteredSubjects().length, (index) {
                        final subject = getFilteredSubjects()[index]
                            .subjectsName
                            .toLowerCase();

                        if (subjectSubfields.containsKey(subject)) {
                          return PopupMenuButton<String>(
                            onSelected: (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReceiveFeedback(
                                    subjectName: value,
                                    feedbackType: "Today_Lessons",
                                    stage: selectedStage,
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
                                        ),
                                      ))
                                  .toList();
                            },
                            child: SubjectsName(
                                details: getFilteredSubjects()[index]),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReceiveFeedback(
                                    subjectName: getFilteredSubjects()[index]
                                        .subjectsName,
                                    feedbackType: "Today_Lessons",
                                    stage: selectedStage,
                                  ),
                                ),
                              );
                            },
                            child: SubjectsName(
                                details: getFilteredSubjects()[index]),
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
