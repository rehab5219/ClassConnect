import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/student/today_lessons/receive_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../widgets/students_name.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200.h,
                width: double.infinity.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AssetsManager.girlStudent),
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
                        color: Colors.grey.withAlpha(150),
                        spreadRadius: 6,
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.r),
                    ),
                    color: Colors.blue.withAlpha(150),
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 15.w,
                child: Text(
                  "classconnect".tr(),
                  style:
                      getHeadTextStyle().copyWith(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('students')
                  .doc(uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      'assets/icons/Classroom.json',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("no student yet".tr(), style: getHeadTextStyle()),
                      Image(image: AssetImage(AssetsManager.searchConcept)),
                    ],
                  );
                }

                final studentData =
                    snapshot.data!.data() as Map<String, dynamic>;
                final student = StudentModel.fromJson(studentData);

                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiveFeedback(
                              feedbackType: "Students",
                            ),
                          ),
                        );
                      },
                      child: StudentsName(student: student),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
