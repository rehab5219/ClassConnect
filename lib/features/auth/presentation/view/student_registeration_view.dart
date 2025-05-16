import 'dart:io';



import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_cubit.dart';
import 'package:classconnect/features/student/student_nav_bar/student_nav_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class StudentRegistrationView extends StatefulWidget {
  const StudentRegistrationView({super.key});

  @override
  _StudentRegistrationViewState createState() =>
      _StudentRegistrationViewState();
}

class _StudentRegistrationViewState extends State<StudentRegistrationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;

  Future<void> _getUser() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> uploadImageToFirebase(File image) async {
    Reference ref =
        FirebaseStorage.instanceFor(bucket: "gs://se7ety-117.appspot.com")
            .ref()
            .child('doctors/$userID-${DateTime.now().toUtc()}');
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: Center(
            child: Text(
              'Complete registration process',
              style: getTitleTextStyle(color: AppColors.whiteColor),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            // backgroundColor: AppColors.lightBg,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                              (_imagePath != null)
                                  ? FileImage(File(_imagePath!))
                                  : const AssetImage(AssetsManager.smilingBoy),
                            ),
                          ),
                          GestureDetector(
                            onTap: ()async {
                              await _pickImage(); 
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                // color: AppColors.color1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(145),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              ' Phone Number',
                              style: getBodyTextStyle(
                                  color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: getSmallTextStyle(),
                        controller: _phone,
                        decoration: InputDecoration(
                          hintText: '+20xxxxxxxxxx',
                          hintStyle: getBodyTextStyle()
                              .copyWith(color: AppColors.greyColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.redColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 25.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: CustomButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                profileUrl = await uploadImageToFirebase(file!);
                context.read<AuthCubit>().updateStudentRegistration(StudentModel(
                      uid: userID,
                      image: profileUrl,
                      phone1: _phone.text,
                    ));
                    // ignore: use_build_context_synchronously
                    return push(context, const StudentNavBarScreen());
              }else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please upload your profile picture'),
                  ),
                );
              }
            },
              text: 'Registration',
            ),
          ),
        ),
      ),
    );
  }
}
