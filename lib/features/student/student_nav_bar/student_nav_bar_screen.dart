import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/features/student/advices/advices_screen.dart';
import 'package:classconnect/features/student/assignment/assignment_screen.dart';
import 'package:classconnect/features/student/profile/student_profile_screen.dart';
import 'package:classconnect/features/student/today_lessons/today_lessons_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../home/presentation/view/home_screen.dart';


class StudentNavBarScreen extends StatefulWidget {
  const StudentNavBarScreen({
    super.key,
  });

  @override
  State<StudentNavBarScreen> createState() => _StudentNavBarScreenState();
}

class _StudentNavBarScreenState extends State<StudentNavBarScreen> {
  List<Widget> screens = [
      HomeScreen(),
     TodayLessonsScreen(),
    const AssignmentScreen(),
    const AdvicesScreen(),
    const StudentProfileScreen(),
  ];
  int _pages = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 45.h,
        key: _bottomNavigationKey,
        items: <Widget>[
          Image.asset(
            AssetsManager.homePng,
            width: 35.w,
            height: 35.h,
            color: AppColors.whiteColor,
          ),
          Image.asset(
            AssetsManager.todayLessonsPng,
            width: 35.w,
            height: 35.h,
            color: AppColors.whiteColor,
          ),
          Image.asset(
            AssetsManager.assignmentPng,
            width: 35.w,
            height: 35.h,
            color: AppColors.whiteColor,
          ),
          Image.asset(
            AssetsManager.advisePng,
            width: 35.w,
            height: 35.h,
            color: AppColors.whiteColor,
          ),
          Image.asset(
            AssetsManager.personPng,
            width: 35.w,
            height: 35.h,
            color: AppColors.whiteColor,
          ),
        ],
        color: AppColors.primaryColor,
        backgroundColor: AppColors.transparent,
        buttonBackgroundColor: AppColors.primaryColor,
        onTap: (index) {
          setState(() {
            _pages = index;
          });
        },
      ),
      body: screens[_pages],
    );
  }
}
