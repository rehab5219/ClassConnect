import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/functions/format_date.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ReceiveFeedback extends StatelessWidget {
  final String? feedbackType;

  final String? subjectName;

  final String? stage;

  ReceiveFeedback({
    super.key,
    this.feedbackType,
    this.subjectName,
    this.stage,
  });

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Iconsax.arrow_left, color: AppColors.whiteColor),
        ),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/icons/Classroom.json',
                height: 250.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'no feedbacks available'.tr(),
                style: getTitleTextStyle().copyWith(color: AppColors.whiteColor),
              ),
            );
          }

          final feedbacks = snapshot.data!;

          return ListView.builder(
            itemCount: feedbacks.length,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemBuilder: (context, index) {
              final f        = feedbacks[index];
              final fDate    = DateTime.parse(f['date']);
              final isRecent = DateTime.now().difference(fDate).inDays <= 5;

              if (!isRecent) return const SizedBox.shrink();

              final stageExists = f.data().toString().contains('stage') &&
                  f['stage'] != null &&
                  f['stage'] != '' &&
                  f['stage'] != 'N/A';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                color: AppColors.whiteColor,
                child: ListTile(
                  title: Text(
                    f['message'] ?? 'no message'.tr(),
                    style: getHeadTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      children: [
                        Text(
                          'Date: ${formatDate(f['date'])}',
                          style: getBodyTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Day: ${f['day'] ?? 'N/A'}',
                          style: getBodyTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        if (stageExists) ...[
                          SizedBox(height: 5.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withAlpha(40),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Stage: ${f['stage']}'.tr(),
                              style: getBodyTextStyle().copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<QueryDocumentSnapshot>> _fetchFeedbacks() async {
    if (user == null) return [];

    final studentUid = user!.uid;
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('feedbacks');

    // ---------- flags -----------------------------------------------------
    final hasFeedbackType = feedbackType != null && feedbackType!.isNotEmpty;
    final hasSubjectName  = subjectName != null && subjectName!.isNotEmpty;
    final hasStage        = stage != null && stage!.isNotEmpty && stage != 'All';

    // ---------- main filters ---------------------------------------------
    if (hasFeedbackType && feedbackType == 'Students') {
      // Personal feedback → must match UID
      query = query
          .where('feedbackType', isEqualTo: feedbackType)
          .where('uid', isEqualTo: studentUid);
    } else {
      if (hasFeedbackType) query = query.where('feedbackType', isEqualTo: feedbackType);
      if (hasSubjectName)  query = query.where('subjectName',  isEqualTo: subjectName);
      if (hasStage)        query = query.where('stage',        isEqualTo: stage);
    }

    // ---------- restrict to this student’s teachers (except 'Students') --
    if (hasFeedbackType && feedbackType != 'Students') {
      final studentDoc = await FirebaseFirestore.instance
          .collection('selected_students')
          .doc(studentUid)
          .get();

      final teacherIds =
          (studentDoc.data()?['teacherIds'] as List?)?.cast<String>() ?? [];

      if (teacherIds.isNotEmpty) {
        query = query.where('teacherId', whereIn: teacherIds);
      }
    }

    // ---------- execute ---------------------------------------------------
    final snapshot = await query.get();

    // newest first
    final feedbacks = snapshot.docs
      ..sort((a, b) =>
          DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));

    return feedbacks;
  }
}
