import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/intro/onboarding/onboarding_model.dart';
import 'package:classconnect/features/intro/welcome_screen.dart';
import 'package:classconnect/service/local/local_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  final UserType? userType;

  const OnboardingView({super.key, this.userType});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  var pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: 3,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Image.asset(
                  pages[index].image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 450),
                  height: 295,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/girl-student-with-clapping-teacher.jpg",
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(127),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                        ),
                      ],
                      color: Colors.blue.withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(125),
                      ),
                    ),
                  ),
                ),
                if (currentPage == 2)
                  PositionedDirectional(
                    bottom: 20,
                    start: 20,
                    end: 20,
                    child: Center(
                      child: CustomButton(
                        height: 45,
                        width: 245,
                        bgColor: AppColors.whiteColor,
                        fgColor: AppColors.primaryColor,
                        text: "get started".tr(),
                        onPressed: () {
                          AppLocalStorage.cacheData(
                            key: AppLocalStorage.isOnboardingShown,
                            value: true,
                          );
                          pushAndRemoveUntil(context, const WelcomeScreen());
                        },
                      ),
                    ),
                  ),
                PositionedDirectional(
                  bottom: 20,
                  start: 20,
                  end: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage == 0 || currentPage == 1) ...{
                        TextButton(
                          onPressed: () => pageController.jumpToPage(2),
                          child: Text(
                            "skip".tr(),
                            style: getTitleTextStyle()
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                        IconButton(
                            onPressed: () => pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                            icon: const Icon(Icons.arrow_forward,
                                color: AppColors.whiteColor)),
                      }
                    ],
                  ),
                ),
                PositionedDirectional(
                  bottom: 80,
                  start: 70,
                  end: 50,
                  child: Text(
                    pages[index].body,
                    textAlign: TextAlign.center,
                    style: getTitleTextStyle().copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Gap(50),
                PositionedDirectional(
                  top: 510,
                  start: 45,
                  end: 10,
                  child: Text(
                    pages[index].title,
                    textAlign: TextAlign.center,
                    style: getHeadTextStyle().copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: 250,
                  start: 20,
                  end: 20,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 10,
                        activeDotColor: AppColors.whiteColor,
                        dotColor: AppColors.greyColor,
                        spacing: 8,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
