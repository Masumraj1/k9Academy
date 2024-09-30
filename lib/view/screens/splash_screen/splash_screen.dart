import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/helper/shared_prefe/shared_prefe.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_img/app_img.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() async {
    bool? onBoarding = await SharePrefsHelper.getBool(AppConstants.onBoard);

    bool? isRememberMe =
        await SharePrefsHelper.getBool(AppConstants.isRememberMe);

    String? token = await SharePrefsHelper.getString(AppConstants.bearerToken);

    Future.delayed(const Duration(seconds: 3), () {
      if (onBoarding == null || false) {
        Get.offAllNamed(AppRoute.onBoarding);
      } else if (isRememberMe == true && token.isNotEmpty) {
        Get.offAllNamed(AppRoute.homeScreen);
      } else {
        Get.offAllNamed(AppRoute.signIn);
      }
    });
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              size: 200.r,
              imageSrc: AppImages.logo,
              imageType: ImageType.png,
            ),
            SizedBox(
              height: 100.h,
            ),
            const CustomLoader()
          ],
        ),
      ),
    );
  }
}
