import 'package:classconnect/core/constants/assets_manager.dart';
import 'package:classconnect/core/utils/app_colors.dart';
import 'package:classconnect/core/utils/styles.dart';
import 'package:classconnect/features/teacher/search/widgets/students_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

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
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: const AssetImage(AssetsManager.girlStudent),
                        alignment: Alignment.topCenter,
                      ),
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80.r),
                      ),
                    ),
                    child: Container(
                      height: 200.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyColor.withValues(alpha: 0.5),
                            spreadRadius: 6,
                            blurRadius: 6,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(80.r),
                        ),
                        color: AppColors.primaryColor.withValues(alpha: 0.6),
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
               Gap(20.sp),
                Padding(
                padding: EdgeInsets.all(15.sp),
                child: TextField(
                  controller: _searchController,
                  style: getSmallTextStyle(),
                  cursorColor: AppColors.primaryColor,
                  onChanged: (searchKey) {
                  setState(() {
                    search = searchKey;
                  });
                  },
                  decoration: InputDecoration(
                  hintText: "search".tr(),
                  hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                  prefixIcon: SizedBox(
                    width: 50.w,
                    child: Icon(Iconsax.search_normal, color: AppColors.primaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.w,
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
                       Gap(50.sp),
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
