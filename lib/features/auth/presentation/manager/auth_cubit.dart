import 'package:classconnect/core/constants/specialization_data.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/auth/models/teacher_model.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());

  register(
      {required String firstName,
      required String secondName,
      required String email,
      required String password,
      required UserType userType}) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, 
          password: password
        );
      User user = credential.user!;
      user.updateDisplayName(firstName + secondName);

      FirebaseFirestore.instance.collection('teachers').doc(user.uid).set({
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

      FirebaseFirestore.instance.collection('students').doc(user.uid).set({
        'firstName': firstName,
        'secondName': secondName,
        'email': email,
        'image': '',
        'phone': '',
        'uid': user.uid,
        'userType': userType.name,
      });

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState('The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState('The account already exists'));
      } else {
        emit(AuthErrorState('An undefined error happened'));
      }
    } catch (e) {
      emit(AuthErrorState('An undefined error happened'));
    }
  }


  login({required String email, required String password})async{
    emit(AuthLoadingState());
    try {
     await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email, 
            password: password
        );

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState('The password is wrong'));
      } else if (e.code == 'user-not-found') {
        emit(AuthErrorState('user-not-found'));
      } else {
        emit(AuthErrorState('An undefined error happened'));
      }
    } catch (e) {
      emit(AuthErrorState('An undefined error happened'));
    }
  }

  updateTeacherRegistration(TeacherModel model) async {
    emit(AuthLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('teacher')
          .doc(model.uid)
          .update({
        'name': model.name,   
        'image': model.image,
        'specialization': model.specialization,
        'phone1': model.phone1,
        'bio': model.bio,
      });

      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  updateStudentRegistration(StudentModel model) async {
    emit(AuthLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(model.uid)
          .update({
        'name': model.name,   
        'image': model.image,
        'phone1': model.phone1,
      });

      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
