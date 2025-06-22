import 'package:classconnect/core/models/week_lessons_data.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/core/widgets/week_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../core/utils/app_colors.dart';

class SubjectsDetails extends StatefulWidget {
  final String subjectName;
  final String? studentId;
  final String feedbackType;

  const SubjectsDetails({
    super.key,
    required this.subjectName,
    required this.feedbackType,
    this.studentId,
  });

  @override
  State<SubjectsDetails> createState() => _SubjectsDetailsState();
}

class _SubjectsDetailsState extends State<SubjectsDetails> {
  late final String uid;
  late final String teacherId;
  late final String message;
  late final String date;

  late final List<String> weekList;
  late final List<TextEditingController> feedbackControllers;

  @override
  void initState() {
    super.initState();
    uid = widget.studentId ?? 'null';
    teacherId = 'TeacherId';
    message = 'message';
    date = 'date';
    weekList = [
      "sunday".tr(),
      "monday".tr(),
      "tuesday".tr(),
      "wednesday".tr(),
      "thursday".tr(),
    ];

    feedbackControllers = List.generate(
      weekList.length,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in feedbackControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 20.w,
                ),
                WeekTextFormField(
                  weekList: WeekLessonsData(weekName: weekList[index]),
                  controller:
                      feedbackControllers[index], // Assign controller from list
                ),
                const Gap(15),
                SizedBox(
                  height: 50.w,
                  child: CustomButton(
                    text: "send Feedback".tr(),
                    bgColor: AppColors.whiteColor,
                    fgColor: AppColors.primaryColor,
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        final teacherId = user.uid;
                        final message = feedbackControllers[index].text.trim();
                        final date = DateTime.now().toString();

                        if (message.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter a feedback message",
                                  style: getBodyTextStyle()),
                              backgroundColor: AppColors.whiteColor,
                            ),
                          );
                          return;
                        }

                        await FirebaseFirestore.instance
                            .collection('feedbacks')
                            .add({
                          'teacherId': teacherId,
                          'uid': uid,
                          'message': message,
                          'feedbackType': widget.feedbackType,
                          'day': weekList[index],
                          'date': date,
                          'subjectName': widget.subjectName, // Add subject name
                        });

                        feedbackControllers[index].clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Feedback sent successfully",
                                style: getBodyTextStyle()),
                            backgroundColor: AppColors.whiteColor,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Teacher not logged in",
                                style: getBodyTextStyle()),
                            backgroundColor: AppColors.whiteColor,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 16.h,
          ),
          itemCount: weekList.length,
        ),
      ),
    );
  }
}
