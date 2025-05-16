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
      image: 'assets/images/classroom.jpg',
      title: 'ابحث عن دكتور متخصص',
      body: 'اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات',
    ),
    OnboardingModel(
      image: 'assets/images/classroom.jpg',
      title: 'سهولة الحجز',
      body: 'احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان',
    ),
    OnboardingModel(
      image: 'assets/images/classroom.jpg',
      title: 'أمن وسري',
      body: 'كن مطمئناً لأن خصوصيتك وأمانك هما أهم أولوياتنا',
    ),
  ];