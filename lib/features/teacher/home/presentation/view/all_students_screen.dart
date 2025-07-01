import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class AllStudentsScreen extends StatefulWidget {
  AllStudentsScreen({super.key});

  @override
  State<AllStudentsScreen> createState() => _AllStudentsScreenState();
}

class _AllStudentsScreenState extends State<AllStudentsScreen> {
  Set<String> selectedStudentIds = {};

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  void toggleStudentSelection(String id) {
    setState(() {
      if (selectedStudentIds.contains(id)) {
        selectedStudentIds.remove(id);
      } else {
        selectedStudentIds.add(id);
      }
    });
  }

  Future<void> saveSelectedStudents(List<StudentModel> allStudents) async {
    final selectedStudents = allStudents
        .where((student) => selectedStudentIds.contains(student.uid))
        .toList();

    final batch = FirebaseFirestore.instance.batch();
    final currentTeacherId =
        FirebaseAuth.instance.currentUser?.uid ?? 'unknown';

    for (var student in selectedStudents) {
      final docRef = FirebaseFirestore.instance
          .collection('selected_students')
          .doc(student.uid);

      batch.set(
        docRef,
        {
          ...student.toJson(),
          'teacherIds': FieldValue.arrayUnion([currentTeacherId]),
        },
        SetOptions(merge: true),
      );
    }

    await batch.commit();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text(
          'Selected students saved!',
          style: getSmallTextStyle(color: AppColors.whiteColor),
        ),
      ),
    );
  }

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
                    image: AssetImage(AssetsManager.girlStudent),
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
                        color: AppColors.greyColor.withAlpha(150),
                        spreadRadius: 6,
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.r),
                    ),
                    color: Colors.blue.withAlpha(150),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(
                        Iconsax.arrow_left,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Gap(10.sp),
                    Text(
                      "all Students".tr(),
                      style: getHeadTextStyle()
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(15.sp),

          /// SEARCH FIELD
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: TextField(
              controller: searchController,
              style: getSmallTextStyle(),
              cursorColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "search".tr(),
                hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                prefixIcon: SizedBox(
                  width: 50.w,
                  child: Icon(Iconsax.search_normal,
                      color: AppColors.primaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.w,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          Gap(10.h),

          /// STUDENT LIST
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('students').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Lottie.asset(
                    'assets/icons/Classroom.json',
                    height: 200.h,
                    width: double.infinity.w,
                    fit: BoxFit.contain,
                  ),
                );
              }

              final studentsDocs = snapshot.data!.docs;

              if (studentsDocs.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Text("no students yet".tr(), style: getBodyTextStyle()),
                      Gap(10.sp),
                      Image.asset(AssetsManager.searchConcept),
                    ],
                  ),
                );
              }

              final students = studentsDocs
                  .map((doc) =>
                      StudentModel.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();

              final filteredStudents = students.where((student) {
                final fullName =
                    '${student.firstName ?? ''} ${student.secondName ?? ''}'
                        .toLowerCase();
                return fullName.contains(searchQuery);
              }).toList();

              return Expanded(
                flex: 2,
                child: filteredStudents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "no student for this name".tr(),
                              style: getHeadTextStyle(),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.w,
                              mainAxisSpacing: 15.h,
                              padding: EdgeInsets.all(12.sp),
                              children: List.generate(filteredStudents.length,
                                  (index) {
                                final student = filteredStudents[index];
                                final isSelected =
                                    selectedStudentIds.contains(student.uid);
                                return InkWell(
                                  onTap: () =>
                                      toggleStudentSelection(student.uid!),
                                  child: Stack(
                                    children: [
                                      Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                radius: 40.r,
                                                backgroundImage: NetworkImage(
                                                  student.image ?? '',
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${student.firstName ?? ''} ${student.secondName ?? ''}',
                                                style: getBodyTextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0.h,
                                        left: 53.w,
                                        child: Checkbox(
                                          activeColor: AppColors.primaryColor,
                                          value: isSelected,
                                          onChanged: (_) =>
                                              toggleStudentSelection(
                                                  student.uid!),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: CustomButton(
                              width: 320.w,
                              text: "save selected students".tr(),
                              onPressed: () => saveSelectedStudents(students),
                              bgColor: AppColors.primaryColor,
                              fgColor: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
