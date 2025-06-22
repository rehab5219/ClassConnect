import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentsName extends StatelessWidget {
  final StudentModel student;
  final void Function()? onTap;

  const StudentsName({this.onTap, required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 200,
        child: Transform.translate(
          offset: const Offset(0, -60),
          child: Card(
            elevation: 7,
            child: Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              student.image as String,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${student.firstName ?? ''} ${student.secondName ?? ''}',
                      style: getBodyTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
