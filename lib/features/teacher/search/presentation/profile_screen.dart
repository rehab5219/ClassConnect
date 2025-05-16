import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/auth/models/student_model.dart';
import 'package:classconnect/features/teacher/search/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudentProfileScreen extends StatefulWidget {
  final StudentModel? studentModel;
  const StudentProfileScreen({
    super.key,
    this.studentModel,
  });

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  late StudentModel student;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Student Profile',
          style: getTitleTextStyle(color: AppColors.whiteColor),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: (widget.studentModel?.image != null)
                          ? NetworkImage(widget.studentModel!.image!)
                          : const AssetImage(AssetsManager.smilingBoy),
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Information Contact',
                      style: getBodyTextStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor.withAlpha(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TileWidget(
                              text: widget.studentModel?.email ?? '',
                              icon: Icons.email),
                          const SizedBox(
                            height: 15,
                          ),
                          TileWidget(
                              text: widget.studentModel?.phone1 ?? '',
                              icon: Icons.call),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


    //   bottomNavigationBar: Container(
    //     margin: const EdgeInsets.all(10),
    //     padding: const EdgeInsets.only(top: 25.0),
    //     child: SizedBox(
    //       width: double.infinity,
    //       height: 50,
    //       child: CustomButton(
    //         onPressed: () async {
    //           if (_formKey.currentState!.validate()) {
    //             profileUrl = await uploadImageToFirebase(file!);
    //             context.read<AuthCubit>().updateDoctorRegistration(DoctorModel(
    //                   uid: userID,
    //                   image: profileUrl,
    //                   phone1: _phone1.text,
    //                   phone2: _phone2.text,
    //                   address: _address.text,
    //                   specialization: _specialization,
    //                   openHour: _startTime,
    //                   closeHour: _endTime,
    //                   bio: _bio.text,
    //                 ));
    //           } else {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               const SnackBar(
    //                 content: Text('من فضلك قم بتحميل صورتك الشخصية'),
    //               ),
    //             );
    //           }
    //         },
    //         text: "التسجيل",
    //       ),
    //     ),
    //   ),
    // );
    // },