import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/functions/format_date.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ReceiveFeedback extends StatelessWidget {
  final String? feedbackType; // Optional parameter for filtering
  final String? subjectName; // Optional parameter for subject filtering

  ReceiveFeedback({
    super.key,
    this.feedbackType,
    this.subjectName,
  });

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.whiteColor,
          ),
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
                width: double.infinity.w,
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
                "no feedbacks available".tr(),
                style:
                    getTitleTextStyle().copyWith(color: AppColors.whiteColor),
              ),
            );
          }

          final feedbacks = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    final feedback = feedbacks[index];
                    return Card(
                      margin: EdgeInsets.all(10.sp),
                      color: AppColors.whiteColor,
                      child: ListTile(
                        title: Text(
                          feedback['message'] ?? "no message".tr(),
                          style: getHeadTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          'Date: ${formatDate(feedback['date'])}\n'
                          'Day: ${feedback['day'] ?? 'N/A'}\n',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<QueryDocumentSnapshot>> _fetchFeedbacks() async {
    if (user == null) return [];

    final studentUid =
        user!.uid; // Current student's UID, assumed not null for "Students"

    List<QueryDocumentSnapshot> feedbacks = [];

    // Start with an empty query
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('feedbacks');

    // Apply filtering based on feedbackType and subjectName
    bool hasFeedbackType = feedbackType != null && feedbackType!.isNotEmpty;
    bool hasSubjectName = subjectName != null && subjectName!.isNotEmpty;

    if (hasFeedbackType && feedbackType == "Students") {
      // Special case for "Students": filter by feedbackType and uid
      query = query
          .where('feedbackType', isEqualTo: feedbackType)
          .where('uid', isEqualTo: studentUid);
    } else if (hasFeedbackType && hasSubjectName) {
      // Filter by both feedbackType and subjectName for other types
      query = query
          .where('feedbackType', isEqualTo: feedbackType)
          .where('subjectName', isEqualTo: subjectName);
    } else if (hasFeedbackType) {
      // Filter by feedbackType only for other types
      query = query.where('feedbackType', isEqualTo: feedbackType);
    } else if (hasSubjectName) {
      // Filter by subjectName only
      query = query.where('subjectName', isEqualTo: subjectName);
    }

    // Fetch teacherIds from selected_students only if not "Students" type
    if (hasFeedbackType && feedbackType != "Students") {
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

    // Fetch the data without server-side sorting
    final querySnapshot = await query.get();

    feedbacks.addAll(querySnapshot.docs);

    // Sort locally by date in descending order
    feedbacks.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date'].toString());
      DateTime dateB = DateTime.parse(b['date'].toString());
      return dateB.compareTo(dateA); // Descending order
    });

    return feedbacks;
  }
}
