import 'package:easy_localization/easy_localization.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String body;

  
  OnboardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List <OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/scheduling-agenda.jpg',
      title: "organize your academic life".tr(),
      body: "easily manage schedules, tasks, and notes—everything you need to stay on top of your studies, all in one place.".tr(),
    ),
    OnboardingModel(
      image: 'assets/images/pexels-kowalievska-4088463.jpg',
      title: "stay updated instantly".tr(),
      body: "get real-time updates on assignments, announcements, and class changes—no more scrambling last minute.".tr(),
    ),
    OnboardingModel(
      image: 'assets/images/pexels-rdne-7821750.jpg',
      title: "smart Communication Tools".tr(),
      body: "no more lost messages or messy group chats—everything’s organized and easy to find.".tr(),
    ),
  ];