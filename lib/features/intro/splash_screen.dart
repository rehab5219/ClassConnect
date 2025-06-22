import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/features/intro/onboarding/onboarding_view.dart';
import 'package:classconnect/features/intro/welcome_screen.dart';
import 'package:classconnect/features/student/student_nav_bar/student_nav_bar_screen.dart';
import 'package:classconnect/features/teacher/teacher_nav_bar/teacher-nav_bar_screen.dart';
import 'package:classconnect/service/local/local_storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure SharedPreferences is initialized (move to main.dart if not already)
    AppLocalStorage.init();
    Future.delayed(const Duration(seconds: 3), () {
      bool isOnboardingShown =
          AppLocalStorage.getData(key: AppLocalStorage.isOnboardingShown) ?? false;
      bool hasSeenWelcome =
          AppLocalStorage.getData(key: AppLocalStorage.hasSeenWelcome) ?? false;
      bool isLoggedIn =
          AppLocalStorage.getData(key: AppLocalStorage.isLoggedIn) ?? false;
      String? userType =
          AppLocalStorage.getData(key: AppLocalStorage.userType).toString();
      if (!isOnboardingShown) {
        pushAndRemoveUntil(context, const OnboardingView());
      } else if (!hasSeenWelcome) {
        pushAndRemoveUntil(context, const WelcomeScreen());
      } else if (isLoggedIn) {
        if (userType == 'teacher') {
          pushAndRemoveUntil(context, const TeacherNavBarScreen());
        } else if (userType == 'student') {
          pushAndRemoveUntil(context, const StudentNavBarScreen()); // Adjust to student screen if different
        } else {
          pushAndRemoveUntil(context, const WelcomeScreen());
        }
      } else {
        pushAndRemoveUntil(context, const WelcomeScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset('assets/icons/Main Scene class.json',width: 300),
            Image.asset(
              "assets/images/logo 1.png",
              height: 500,
            ),
          ],
        ),
      ),
    );
  }
}
