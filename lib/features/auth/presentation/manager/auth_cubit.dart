import 'dart:developer';

import 'package:classconnect/core/constants/specialization_data.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/auth/models/teacher_model.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());

  void register({
    required String firstName,
    required String secondName,
    required String email,
    required String password,
    required UserType userType,
  }) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;
      user.updateDisplayName(firstName + secondName);

      if (userType == UserType.teacher) {
        await FirebaseFirestore.instance.collection('teachers').doc(user.uid).set({
          'firstName': firstName,
          'secondName': secondName,
          'email': email,
          'specialization': specialization,
          'bio': '',
          'image': '',
          'phone': '',
          'uid': user.uid,
          'userType': userType.name,
        });
      } else {
        await FirebaseFirestore.instance.collection('students').doc(user.uid).set({
          'firstName': firstName,
          'secondName': secondName,
          'email': email,
          'image': '',
          'phone': '',
          'uid': user.uid,
          'userType': userType.name,
        });
      }

      // Save user data and type to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', user.uid);
      await prefs.setString('email', email);
      await prefs.setString('userType', userType.name);
      await prefs.setBool('isLoggedIn', true); // Mark as logged in
      await prefs.setBool('hasSeenWelcome', true); // Mark as logged in
      await prefs.setBool('isOnboardingShown', true); // Mark as logged in

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState("the password provided is too weak".tr()));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState("the account already exists".tr()));
      } else {
        emit(AuthErrorState("an undefined error happened".tr()));
      }
    } catch (e) {
      emit(AuthErrorState("an undefined error happened".tr()));
    }
  }

  void login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;

      // Fetch user type from Firestore
      String userType = await _getUserType(user.uid);

      // Save user data and type to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', user.uid);
      await prefs.setString('email', email);
      await prefs.setString('userType', userType);
      await prefs.setBool('isLoggedIn', true); // Mark as logged in
      await prefs.setBool('hasSeenWelcome', true); // Mark as logged in
      await prefs.setBool('isOnboardingShown', true); // Mark as logged in

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        emit(AuthErrorState("the password is wrong".tr()));
      } else if (e.code == 'user-not-found') {
        emit(AuthErrorState("user not found".tr()));
      } else {
        emit(AuthErrorState("an undefined error happened".tr()));
      }
    } catch (e) {
      emit(AuthErrorState("an undefined error happened".tr()));
    }
  }

  // Helper method to get user type from Firestore
  Future<String> _getUserType(String uid) async {
    final teacherDoc = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(uid)
        .get();
    if (teacherDoc.exists) {
      return 'teacher';
    }
    final studentDoc = await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .get();
    if (studentDoc.exists) {
      return 'student';
    }
    return 'unknown'; // Fallback if not found
  }


  updateTeacherRegistration(TeacherModel model) async {
    emit(AuthLoadingState());
    log(model.uid.toString());
    try {
      await FirebaseFirestore.instance
          .collection('teachers')
          .doc(model.uid)
          .update({
        'image': model.image,
        'specialization': model.specialization,
        'phone1': model.phone1,
        'bio': model.bio,
      });

      emit(AuthSuccessState());
    } on Exception catch (e) {
      log(e.toString());
      emit(AuthErrorState(e.toString()));
    }
  }

  updateStudentRegistration(StudentModel model) async {
    emit(AuthLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(model.uid)
          .update({
        'image': model.image,
        'phone1': model.phone1,
      });

      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
