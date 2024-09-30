import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';

class GeneralErrorScreen extends StatelessWidget {
  const GeneralErrorScreen({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueNormal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const CustomImage(imageSrc: AppImages.noInternetImage),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Something wrong!",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.blueNormal),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueNormal,
                  minimumSize: Size(Get.width / 1.6, 40.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32.r),
                        bottomLeft: Radius.circular(32.r),
                      ))),
              child: const Text(
                "Try Again",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}