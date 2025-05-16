import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/features/student/advices/advices_screen.dart';
import 'package:classconnect/features/student/profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../teacher/assignment/assignment_screen.dart';
import '../home/presentation/view/home_screen.dart';
import '../../teacher/today_lessons/presentation/view/today_lessons_screen.dart';

class StudentNavBarScreen extends StatefulWidget {
  const StudentNavBarScreen({
    super.key,
  });

  @override
  State<StudentNavBarScreen> createState() => _StudentNavBarScreenState();
}

class _StudentNavBarScreenState extends State<StudentNavBarScreen> {
  List<Widget> screens = [
     const HomeScreen(),
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
          SvgPicture.asset(
            AssetsManager.home,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            AssetsManager.todayLessons,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            AssetsManager.assignment,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            AssetsManager.advise,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            AssetsManager.person,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
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
