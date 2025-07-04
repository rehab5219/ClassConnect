import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsSearch extends StatelessWidget {
  final StudentModel student;
  final void Function()? onTap;

  const StudentsSearch({this.onTap, required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200.h,
        width: 200.w,
        child: Transform.translate(
          offset: const Offset(0, -60),
          child: Card(
            elevation: 7,
            child: Center(
              child: Text(
                '${student.firstName ?? ''} ${student.secondName ?? ''}',
                style: getTitleTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
