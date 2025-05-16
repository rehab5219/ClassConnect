import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/styles.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      "assets/images/girl-student-with-clapping-teacher.jpg",
                    ),
                  ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80.r),
                  ),
                ),
                child: Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 6,
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.r),
                    ),
                    color: Colors.blue.withValues(alpha: 0.6),
                  ),
                ),
              ),
              // Padding(
              Positioned(
                bottom: 20.h,
                left: 15.w,
                child: Text(
                  "ADVICES",
                  style: getHeadTextStyle().copyWith(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30
          ),
          Container(
            height: 450,
            width: 300,
            child: Card(
              margin: EdgeInsets.zero,
              color: AppColors.primaryColor,
              child: Text(
                textAlign: TextAlign.center,
                maxLines: 20,
                "Advices for parent",
                style: getHeadTextStyle().copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}