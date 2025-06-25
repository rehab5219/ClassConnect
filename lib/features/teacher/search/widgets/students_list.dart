import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/teacher/search/presentation/student_profile.dart';
import 'package:classconnect/features/teacher/search/widgets/students_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({
    super.key,
    required this.searchKey,
  });

  final String searchKey;

  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    print('Search Key: ${widget.searchKey}'); // Debug log for search key
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('students')
          .orderBy('firstName') // Corrected to 'firstName'
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting for data...'); // Debug log
          return Center(
            child: Lottie.asset(
              'assets/icons/Classroom.json',
              height: 200.h,
              width: double.infinity.w,
              fit: BoxFit.contain,
            ),
          );
        }
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}'); // Debug log for errors
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print(
              'No data or empty: ${snapshot.data?.docs.length} documents'); // Debug log
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsManager.searchConcept,
                  width: 250.w,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16.h),
                Text(
                  "no student for this name".tr(),
                  style: getBodyTextStyle().copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }
        print(
            'Data fetched: ${snapshot.data!.docs.length} documents'); // Debug log

        // Filter students based on searchKey
        final filteredStudents = snapshot.data!.docs.where((doc) {
          final student =
              StudentModel.fromJson(doc.data() as Map<String, dynamic>);
          final fullName =
              '${student.firstName} ${student.secondName ?? ''}'.toLowerCase();
          final searchTerm = widget.searchKey.toLowerCase();
          return widget.searchKey.isEmpty || fullName.contains(searchTerm);
        }).toList();

        return filteredStudents.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsManager.searchConcept,
                      width: 250.w,
                      height: 150.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "no student for this name".tr(),
                      style: getBodyTextStyle().copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredStudents.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8.h,
                    mainAxisSpacing: 8.w,
                  ),
                  itemBuilder: (context, index) {
                    StudentModel student = StudentModel.fromJson(
                      filteredStudents[index].data() as Map<String, dynamic>,
                    );
                    return StudentsSearch(
                      student: student,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentProfile(
                              studentModel: student,
                              userId: student.uid,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
      },
    );
  }
}
