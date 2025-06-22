import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/teacher/home/presentation/view/all_students_screen.dart';
import 'package:classconnect/features/teacher/home/presentation/widgets/students.dart';
import 'package:classconnect/features/teacher/today_lessons/presentation/view/subjects_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<QuerySnapshot> _studentsFuture;
  final String? currentTeacherId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _studentsFuture = _fetchStudents();
  }

  void _refreshStudents() {
    setState(() {
      _studentsFuture = _fetchStudents();
    });
  }

  Future<QuerySnapshot> _fetchStudents() async {
    if (currentTeacherId == null) {
      return await FirebaseFirestore.instance
          .collection('selected_students')
          .where('uid', isEqualTo: 'non_existent_uid')
          .limit(0)
          .get();
    }
    return await FirebaseFirestore.instance
        .collection('selected_students')
        .where('teacherIds', arrayContains: currentTeacherId)
        .get();
  }

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
              PositionedDirectional(
                top: 40,
                child: IconButton(
                  icon: Icon(Icons.refresh, color: AppColors.whiteColor),
                  onPressed: _refreshStudents,
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
          const Gap(15),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _studentsFuture,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Lottie.asset(
                      'assets/icons/Classroom.json',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  );
                }

                final students = snapshot.data!.docs;

                if (students.isEmpty) {
                  return InkWell(
                    onTap: () {
                      _refreshStudents();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("no selected students yet".tr(),
                            style: getTitleTextStyle()),
                        Gap(10.h),
                        Image(image: AssetImage(AssetsManager.searchConcept)),
                      ],
                    ),
                  );
                }

                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  padding: EdgeInsets.all(12.w),
                  children: List.generate(students.length, (index) {
                    final student = StudentModel.fromJson(
                        students[index].data() as Map<String, dynamic>);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubjectsDetails(
                              subjectName: student.firstName ?? '',
                              studentId: student.uid ?? '',
                              feedbackType: "Students",
                            ),
                          ),
                        );
                      },
                      child: Students(
                        student: student,
                        onDelete: _refreshStudents,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, AllStudentsScreen());
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 40.sp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
