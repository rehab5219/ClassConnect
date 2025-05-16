import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/models/week_lessons_data.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/week_text_form_field.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/student/home/models/students_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StudentsName extends StatelessWidget {
  StudentsName({super.key, required this.student, required this.isClickable, required this.weekList, required this.data, this.onTap});

  final StudentsData data;
  final void Function()? onTap;
  final StudentModel student;
  final WeekLessonsData weekList;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // () {
      //   if (isClickable) {
      //     push(context, WeekTextFormField(weekList: weekList,));
      //   }
      // },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 7,
        child: Column(
          children: [
            // Expanded(
            //   flex: 2,
            //   child: Image.asset(
            //     student.image ?? '',
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
                child: Text(
                  data.studentName,
                  style: getTitleTextStyle(),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
