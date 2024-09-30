import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/my_profile_screen/profile_controller/profile_controller.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';

class TabBarWidgets extends StatelessWidget {
  const TabBarWidgets({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ///==========================Profile Tab Bar==================================
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: profileController.selectedIndex.value == 0
                  ? AppColors.redNormal
                  : AppColors.blackyDarkHover,
            ),
            child: TextButton(
              onPressed: () {
                profileController.changeTab(0);
              },
              child: CustomText(
                text: AppStaticStrings.profile,
                color: AppColors.lightNormal,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ///==========================Post Tab Bar==================================
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: profileController.selectedIndex.value == 1
                  ? AppColors.redNormal
                  : AppColors.blackyDarkHover,
            ),
            child: TextButton(
              onPressed: () {
                profileController.changeTab(1);
              },
              child: CustomText(
                text: AppStaticStrings.posts,
                color: AppColors.lightNormal,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ///==========================Package Tab Bar==================================
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: profileController.selectedIndex.value == 2
                  ? AppColors.redNormal
                  : AppColors.blackyDarkHover,
            ),
            child: TextButton(
              onPressed: () {
                profileController.changeTab(2);
              },
              child: CustomText(
                text: AppStaticStrings.package,
                color: AppColors.lightNormal,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ///==========================Schedule Tab Bar==================================
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: profileController.selectedIndex.value == 3
                  ? AppColors.redNormal
                  : AppColors.blackyDarkHover,
            ),
            child: TextButton(
              onPressed: () {
                profileController.changeTab(3);
              },
              child: CustomText(
                text: AppStaticStrings.schedule,
                color: AppColors.lightNormal,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    });
  }
}
