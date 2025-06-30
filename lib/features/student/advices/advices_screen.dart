import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/styles.dart';

class AdvicesScreen extends StatefulWidget {
  const AdvicesScreen({super.key});

  @override
  _AdvicesScreenState createState() => _AdvicesScreenState();
}

class _AdvicesScreenState extends State<AdvicesScreen> {
  bool _isArabic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AssetsManager.girlStudent,
                      ),
                    ),
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.r),
                    ),
                  ),
                  child: Container(
                    height: 200.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withValues(alpha: 0.5),
                          spreadRadius: 6,
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80.r),
                      ),
                      color: AppColors.primaryColor.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 20.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: IconButton(
                      icon: Icon(
                        Iconsax.language_square,
                        color: AppColors.whiteColor,
                        size: 35.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _isArabic = !_isArabic;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  child: Text(
                    "advices".tr(),
                    style: getHeadTextStyle()
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Text(
                    textAlign: TextAlign.center,
                    _isArabic
                        ? "نصائح للوالدين\n\n"
                            "بناء علاقة عاطفية قوية\n"
                            "أظهر الحب غير المشروط من خلال العاطفة، الاستماع النشط، والوقت الجيد. هذا يعزز الثقة والأمان العاطفي.\n\n"
                            "وضع حدود واضحة وقواعد متسقة\n"
                            "حدد قواعد مناسبة للعمر لتوفير التركيز والأمان. الثبات يساعد الأطفال على فهم التوقعات.\n\n"
                            "شجع الاستقلالية والمسؤولية\n"
                            "اسمح للأطفال بالاختيار والتعلم من الأخطاء، مع زيادة المسؤولية تدريجياً مع نموهم.\n\n"
                            "كن قدوة سلوك إيجابي\n"
                            "الأطفال يتعلمون من مراقبتك. اعرض الطيبة، المرونة، وحل المشكلات لتشكيل قيمهم.\n\n"
                            "روّج التواصل المفتوح\n"
                            "أنشئ فضاءً آمناً للأطفال لمشاركة أفكارهم ومشاعرهم دون خوف من الحكم. اطرح أسئلة مفتوحة وأكد على مشاعرهم.\n\n"
                            "أعط الأولوية لرفاهيتهم\n"
                            "ضمن الصحة البدنية (التغذية، النوم، التمارين) والصحة النفسية (إدارة الضغط، الدعم العاطفي).\n\n"
                            "تكيف مع مراحلهم التنموية\n"
                            "اضبط نهجك حسب عمرهم واحتياجاتهم، مع توازن بين التوجيه والحرية مع نضجهم.\n\n"
                        : "Advices for parents\n\n"
                            "Build a Strong Emotional Connection\n"
                            "Show unconditional love through affection, active listening, and quality time. This fosters trust and emotional security.\n\n"
                            "Set Clear Boundaries and Consistent Rules\n"
                            "Establish age-appropriate rules to provide structure and safety. Consistency helps children understand expectations.\n\n"
                            "Encourage Independence and Responsibility\n"
                            "Allow children to make choices and learn from mistakes, gradually increasing responsibility as they grow.\n\n"
                            "Model Positive Behavior\n"
                            "Children learn by observing you. Demonstrate kindness, resilience, and problem-solving to shape their values.\n\n"
                            "Foster Open Communication\n"
                            "Create a safe space for kids to share thoughts and feelings without fear of judgment. Ask open-ended questions and validate their emotions.\n\n"
                            "Prioritize Their Well-Being\n"
                            "Ensure physical health (nutrition, sleep, exercise) and mental health (stress management, emotional support).\n\n"
                            "Adapt to Their Developmental Stage\n"
                            "Tailor your approach to their age and needs, balancing guidance with freedom as they mature.\n\n",
                    style: getTitleTextStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
