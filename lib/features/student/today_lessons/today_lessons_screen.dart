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

  static List<String> stages = [
    'All',
    ...List.generate(6, (i) => 'Primary ${i + 1}'),
    ...List.generate(3, (i) => 'Prep ${i + 1}'),
    ...List.generate(3, (i) => 'Secondary ${i + 1}'),
  ];

  static const List<String> primarySubjects = [
    'ARABIC',
    'MATH',
    'SCIENCE',
    'ENGLISH',
    'RELIGION',
    'FRENCH',
    'GERMAN'
  ];

  static const List<String> prepSubjects = [...primarySubjects, 'SOCIAL'];

  static const List<String> secondarySubjects = [
    ...prepSubjects,
    'PHILOSOPHY',
    'PSYCHOLOGY'
  ];

  final Map<String, List<String>> stageSubjects = {
    for (var i = 1; i <= 6; i++) 'Primary $i': primarySubjects,
    for (var i = 1; i <= 3; i++) 'Prep $i': prepSubjects,
    for (var i = 1; i <= 3; i++) 'Secondary $i': secondarySubjects,
  };

  String selectedStage = 'All';

  List<SubjectsData> getFilteredSubjects() {
    if (selectedStage == 'All') {
      return details;
    }
    return details.where((subject) {
      return stageSubjects[selectedStage]
              ?.contains(subject.subjectsName.toUpperCase()) ??
          false;
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
                    left: 13.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "today's lessons".tr(),
                          style: getHeadTextStyle()
                              .copyWith(color: AppColors.whiteColor),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 7.h,
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedStage,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.primaryColor,
                                size: 25.sp,
                              ),
                              style: getBodyTextStyle().copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedStage = newValue!;
                                });
                              },
                              items: stages.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value.tr(),
                                    style: getBodyTextStyle(),
                                  ),
                                );
                              }).toList(),
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
                        final bool hasSubfields =
                            subjectSubfields.containsKey(subject);
                        final bool isStageForDropdown =
                            selectedStage.startsWith('Prep') ||
                                selectedStage.startsWith('Secondary') ||
                                selectedStage == 'All';
                        if (hasSubfields && isStageForDropdown) {
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
