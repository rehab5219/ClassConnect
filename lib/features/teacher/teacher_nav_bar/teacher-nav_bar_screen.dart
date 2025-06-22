import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/features/teacher/profile/teacher_profile_screen.dart';
import 'package:classconnect/features/teacher/search/presentation/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../teacher/assignment/assignment_screen.dart';
import '../home/presentation/view/home_screen.dart';
import '../../teacher/today_lessons/presentation/view/today_lessons_screen.dart';

class TeacherNavBarScreen extends StatefulWidget {
  const TeacherNavBarScreen({
    super.key,
  });

  @override
  State<TeacherNavBarScreen> createState() => _TeacherNavBarScreenState();
}

class _TeacherNavBarScreenState extends State<TeacherNavBarScreen> {
  List<Widget> screens = [
      HomeScreen(),
     TodayLessonsScreen(),
    const AssignmentScreen(),
     SearchScreen(),
    const TeacherProfileScreen(),
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
            AssetsManager.searchPng,
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
