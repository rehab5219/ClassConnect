import 'package:classconnect/core/models/subjects_data.dart';
import 'package:classconnect/core/models/week_lessons_data.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/core/widgets/week_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';

class SubjectsDetails extends StatefulWidget {
  final SubjectsData subject;

  const SubjectsDetails({
    super.key,
    required this.subject,
  });

  @override
  State<SubjectsDetails> createState() => _SubjectsDetailsState();
}

class _SubjectsDetailsState extends State<SubjectsDetails> {
  late final String uid;
  late final String teacherId;
  late final String message;
  late final String date;

  final TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uid = 'uid';
    teacherId = 'TeacherId';
    message = 'message';
    date = 'date';
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
            return Row(
              children: [
                WeekTextFormField(
                  weekList: weekList[index],
                ),
                Expanded(
                  child: CustomButton(
                      text: "Send Feedback",
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                  
                        if (user != null) {
                          final teacherId = user.uid;
                          final uid = user.uid;
                          final message = feedbackController.text.trim();
                          final date = DateTime.now().toString();
                  
                          if (message.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("Please enter a feedback message")),
                            );
                            return;
                          }
                  
                          await FirebaseFirestore.instance
                              .collection('feedback')
                              .add({
                            'teacherId': teacherId,
                            'uid': user.uid,
                            'message': message,
                            'date': date,
                          });
                  
                          feedbackController.clear();
                  
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Feedback sent successfully")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Teacher not logged in")),
                          );
                        }
                      }),
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

