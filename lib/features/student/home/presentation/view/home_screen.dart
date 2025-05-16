
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/student/home/models/students_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/models/subjects_data.dart';
import '../../../../teacher/today_lessons/presentation/view/subjects_details.dart';
import '../widgets/students_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
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
                    width: double.infinity.w,
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 50.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("CLASSCONNECT",
                              style: getTitleTextStyle()
                                  .copyWith(color: AppColors.whiteColor)),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.accessibility_new_outlined,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.settings_outlined,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        padding: EdgeInsets.all(12.w),
                        children: [
                          ...List.generate(
                           data?.length ?? 0,
                            (index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SubjectsDetails(
                                          subject: details[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: StudentsName(
                                    data: data![index],
                                  ));
                            },
                          ),
                        ]),
              ),
            ),
          ],
        ),
      );
  }
}
