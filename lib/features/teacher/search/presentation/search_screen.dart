import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/teacher/search/widgets/students_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: const AssetImage(AssetsManager.girlStudent),
                        alignment: Alignment.topCenter,
                      ),
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80.r),
                      ),
                    ),
                    child: Container(
                      height: 200.h,
                      width: double.infinity,
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
                  Positioned(
                    bottom: 20.h,
                    left: 15.w,
                    child: Text(
                      "search".tr(),
                      style: getHeadTextStyle()
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: _searchController,
                  style: getSmallTextStyle(),
                  onChanged: (searchKey) {
                    setState(() {
                      search = searchKey;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "search".tr(),
                    hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                    suffixIcon: const SizedBox(
                      width: 50,
                      child: Icon(Icons.search, color: AppColors.primaryColor),
                    ),
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
                  ),
                ),
              ),
              if (search.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(50),
                      Text("show all students".tr(),
                          style: getHeadTextStyle()),
                      Image(image: AssetImage(AssetsManager.searchConcept)),
                    ],
                  ),
                ),
              if (search.isNotEmpty)
                StudentsList(
                  searchKey: search,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
