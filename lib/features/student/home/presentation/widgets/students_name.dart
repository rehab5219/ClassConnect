

import 'package:classconnect/core/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../models/students_data.dart';
class StudentsName extends StatelessWidget {
  final StudentsData data;
  final void Function()? onTap;

  const StudentsName({this.onTap, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 7,
        child: Column(
          children: [
            // Expanded(
            //   flex: 2,
            //   child: Image.asset(
            //     data.image,
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
