import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_cubit.dart';
import 'package:classconnect/features/student/home/models/students_data.dart';
import 'package:classconnect/features/student/home/presentation/widgets/students_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/models/subjects_data.dart';
import '../../../today_lessons/presentation/view/subjects_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // User? user;

  // Future<void> _getUser() async {
  //   user = _auth.currentUser;
  // }

  // Future<void> deleteStudent(
  //   String docID,
  // ) {
  //   return FirebaseFirestore.instance
  //       .collection('students')
  //       .doc('students')
  //       .collection('pending')
  //       .doc(docID)
  //       .delete();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getUser();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body:
            // StreamBuilder(
            //     stream: FirebaseFirestore.instance
            //         .collection('students')
            //         .doc('students')
            //         .collection('pending')
            //         .snapshots(),
            //     builder:
            //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (!snapshot.hasData) {
            //         return Center(
            //           child: Lottie.asset(
            //             'assets/icons/Classroom.json',
            //           ),
            //         );
            //       }
            //       return
            Column(
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
                        AssetsManager.girlStudent,
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
                      Text("CLASSCONNECT",
                          style: getTitleTextStyle()
                              .copyWith(color: AppColors.whiteColor)),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              //  child: StudentsName(data: data,),
            ),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: GridView.count(
            //         crossAxisCount: 2,
            //         crossAxisSpacing: 15.w,
            //         mainAxisSpacing: 15.h,
            //         padding: EdgeInsets.all(12.w),
            //         children: [
            //           ...List.generate(
            //             snapshot.data?.docs.length ?? 0,
            //             (index) {
            //               return InkWell(
            //                   onTap: () {
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) => SubjectsDetails(
            //                           subject: details[index],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                   child: StudentsName(
            //                     data: data![index],
            //                   ));
            //             },
            //           ),
            //         ]),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
