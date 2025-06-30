import 'package:classconnect/features/teacher/profile/teacher_profile_screen.dart';
import 'package:classconnect/features/teacher/search/presentation/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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
     AssignmentScreen(),
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
        height: 50.h,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(_pages == 0 ? Iconsax.home_21 : Iconsax.home_2,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),

          Icon(_pages == 1 ? Iconsax.calendar5 : Iconsax.calendar_1,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),

          Icon(_pages == 2 ? Iconsax.task_square5 : Iconsax.task_square,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),

          Icon(Iconsax.search_normal,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),

          Icon(_pages == 4 ? Iconsax.profile_circle5 : Iconsax.profile_circle,
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
