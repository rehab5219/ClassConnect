import 'package:classconnect/features/student/advices/advices_screen.dart';
import 'package:classconnect/features/student/assignment/assignment_screen.dart';
import 'package:classconnect/features/student/profile/student_profile_screen.dart';
import 'package:classconnect/features/student/today_lessons/today_lessons_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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
    AssignmentScreen(),
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
          Icon(
            _pages == 0 ? Iconsax.home_21 : Iconsax.home_2,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          Icon(
            _pages == 1 ? Iconsax.calendar5 : Iconsax.calendar_1,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          Icon(
            _pages == 2 ? Iconsax.task_square5 : Iconsax.task_square,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          Icon(
            _pages == 3 ? Iconsax.profile_2user5 : Iconsax.profile_2user,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          Icon(
            _pages == 4 ? Iconsax.profile_circle5 : Iconsax.profile_circle,
            size: 35.sp,
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
