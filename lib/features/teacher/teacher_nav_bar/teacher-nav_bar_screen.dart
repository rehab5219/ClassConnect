
import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/features/teacher/search/presentation/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../assignment/assignment_screen.dart';
import '../../student/home/presentation/view/home_screen.dart';
import '../profile/profile_screen.dart';
import '../today_lessons/presentation/view/today_lessons_screen.dart';

class TeacherNavBarScreen extends StatefulWidget {
  const TeacherNavBarScreen({
    super.key,
  });

  @override
  State<TeacherNavBarScreen> createState() => _TeacherNavBarScreenState();
}

class _TeacherNavBarScreenState extends State<TeacherNavBarScreen> {
  List<Widget> screens = [
    const HomeScreen(),
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
          SvgPicture.asset(
            'assets/icons/home.svg',
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/todayLessons.svg',
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/assignment.svg',
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/search.svg',
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/person.svg',
            fit: BoxFit.cover,
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
