import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/enum/user_type_enum.dart';
import 'package:classconnect/core/functions/navigation.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/core/widgets/custom_botton.dart';
import 'package:classconnect/features/auth/presentation/manager/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/app_colors.dart';
import '../auth/presentation/view/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 500,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AssetsManager.girlStudent,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(127),
                  ),
                ),
                child: Container(
                  height: 650,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 7,
                        blurRadius: 7,
                      ),
                    ],
                    color: Colors.blue.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(125),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Easy communication with your child at school".tr(),
                        style: getHeadTextStyle().copyWith(
                            color: AppColors.whiteColor, fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(45),
          Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black,
                    blurRadius: 8,
                    // offset: Offset(5, 5),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Create an account as',
                    style: getTitleTextStyle(color: AppColors.primaryColor),
                  ),
                  const Gap(40),
                  Column(
                    children: [
                      CustomButton(
                        height: 45,
                        width: 220,
                        bgColor: AppColors.primaryColor,
                        fgColor: AppColors.whiteColor,
                        text: 'Teacher',
                        onPressed: () {
                          push(
                            context,
                            BlocProvider(
                              create: (context) => AuthCubit(),
                              child: const SignUpScreen(
                                  userType: UserType.teacher),
                            ),
                          );
                        },
                      ),
                      const Gap(15),
                      CustomButton(
                        height: 45,
                        width: 220,
                        bgColor: AppColors.primaryColor,
                        fgColor: AppColors.whiteColor,
                        text: 'Student',
                        onPressed: () {
                          push(
                            context,
                            const SignUpScreen(userType: UserType.student),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
