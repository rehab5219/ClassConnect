import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ReceiveFeedback extends StatefulWidget {
  const ReceiveFeedback({super.key});

  @override
  State<ReceiveFeedback> createState() => _ReceiveFeedbackState();
}

class _ReceiveFeedbackState extends State<ReceiveFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 450,
              width: 300,
              child: Card(
                margin: EdgeInsets.zero,
                color: AppColors.whiteColor,
                child: Text(
                    textAlign: TextAlign.center,
                    maxLines: 20,
                    "Feedback",
                    style: getHeadTextStyle()),
              ),
            ),
          ],
        ));
  }
}
