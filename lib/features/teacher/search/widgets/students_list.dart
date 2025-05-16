import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class StudentsList extends StatefulWidget {

  const StudentsList({super.key, required this.student, required this.isClickable});

  final StudentModel student;
  final bool isClickable;

  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('students')
          .orderBy('name')
          .startAt([widget.student.name]).endAt(
              ['${widget.student.name}\uf8ff']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Lottie.asset(
              'assets/icons/Classroom.json',
            ),
          );
        }
        return snapshot.data!.docs.isEmpty
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsManager.searchConcept,
                        width: 250,
                      ),
                      Text(
                        'No students found',
                        style: getBodyTextStyle(),
                      ),
                    ],
                  ),
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    StudentModel student = StudentModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );
                    return  StudentsList(
                      isClickable: true, 
                      student: student,
                      // StudentModel.fromJson(
                      //   snapshot.data!.docs[index].data() as Map<String, dynamic>
                      // ),
                    );
                  },
                ),
              );
      },
    );
  }
}
