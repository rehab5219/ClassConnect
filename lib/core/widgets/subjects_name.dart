import 'package:classconnect/core/models/subjects_data.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SubjectsName extends StatelessWidget {
  final SubjectsData details;
  final void Function()? onTap;

  const SubjectsName({super.key, this.onTap, required this.details});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 7,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            details.subjectsName.tr(),
            style: getHeadTextStyle(),
          ),
        ),
      ),
    );
  }
}