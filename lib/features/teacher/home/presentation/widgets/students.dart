import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Students extends StatefulWidget {
  Students({super.key, this.onTap, required this.student, this.onDelete});

  final void Function()? onTap;
  final StudentModel student;
  final VoidCallback? onDelete; // Callback to refresh parent

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

Future<void> deleteStudent(String uid) async {
  try {
    final currentTeacherId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
    final docRef = FirebaseFirestore.instance
        .collection('selected_students')
        .doc(uid);

    // Fetch the current document to get teacherIds
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final teacherIds = (docSnapshot.data()?['teacherIds'] as List?)?.cast<String>() ?? [];
      if (teacherIds.contains(currentTeacherId)) {
        teacherIds.remove(currentTeacherId); // Remove current teacher ID

        // Update the document with the new teacherIds array
        await docRef.update({'teacherIds': teacherIds});

        // If no teacherIds remain, delete the document
        if (teacherIds.isEmpty) {
          await docRef.delete();
        }
      }
    }

    if (widget.onDelete != null) {
      widget.onDelete!(); // Call the refresh callback
    }
  } catch (e) {
    print('Error deleting student $uid: $e');
    rethrow;
  }
}

  showAlertDialog(BuildContext context, String uid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.primaryColor,
            title: Text(
              "delete student".tr(),
              style: getBodyTextStyle(color: AppColors.whiteColor),
            ),
            content: Text(
              "are you sure you want to delete this student?".tr(),
              style: getBodyTextStyle(color: AppColors.whiteColor),
            ),
            actions: [
              TextButton(
                child: Text(
                  "no".tr(),
                  style: getBodyTextStyle(color: AppColors.whiteColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "yes".tr(),
                  style: getBodyTextStyle(color: AppColors.whiteColor),
                ),
                onPressed: () async {
                  await deleteStudent(uid);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: NetworkImage(
                    widget.student.image as String,
                  ),
                ),
              ],
            ),
            Text(
              '${widget.student.firstName ?? ''} ${widget.student.secondName ?? ''}',
              style: getBodyTextStyle(),
            ),
            IconButton(
              onPressed: () {
                showAlertDialog(context, widget.student.uid ?? '');
              },
              icon: const Icon(Icons.delete, color: AppColors.redColor),
            )
          ],
        ),
      ),
    );
  }
}