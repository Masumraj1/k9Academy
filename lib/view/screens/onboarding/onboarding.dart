import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/helper/shared_prefe/shared_prefe.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_img/app_img.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<String> titleFirstPart = [
    "Up A Level K9 is dedicated to helping you discover the greatness in your dog. This app is designed to give you the tools you need to communicate effectively with your dog.",
    "All subscriptions give you access to training videos with Karen Wannemaker. ",
    "We are excited to journey with you and your dog!"
  ];
  int currentIndex = 0;

  @override
  void initState() {
    SharePrefsHelper.setBool(AppConstants.onBoard, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(currentIndex == 0
                ? AppImages.onBoarding1
                : currentIndex == 1
                    ? AppImages.onBoarding2
                    : AppImages.onBoarding3),
          ),
        ),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.01, -.8),
                end: const Alignment(0.01, 1.3),
                colors: [
                  Colors.white.withOpacity(0),
                  const Color(0xFF14344C).withOpacity(.6),
                  const Color(0xFF0B0B0B).withOpacity(.8)
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: titleFirstPart.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///<==================================Title=================================================>
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: CustomText(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32.sp,
                                        color: AppColors.lightNormal,
                                        text: "Welcome!")),
                              ],
                            ),
                          ),

                          ///<===================================Sub Title=================================================>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomText(
                                  top: 8.h,
                                  left: 20,
                                  right: 10,
                                  maxLines: 3,
                                  text: titleFirstPart[index],
                                  fontSize: 16,
                                  color: AppColors.lightNormal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),

                ///<===================================Doted Indicator=================================================>

                DotsIndicator(
                  dotsCount: titleFirstPart.length,
                  position: currentIndex,
                  decorator: const DotsDecorator(
                    color: AppColors.lightDarkActive,
                    activeColor: AppColors.lightNormalHover,
                    activeSize: Size(12.0, 12.0),
                    size: Size.square(12),
                  ),
                ),

                ///<===================================Get Started Button=================================================>

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 64, top: 20),
                  child: CustomButton(
                    fillColor: AppColors.redNormal,
                    title: AppStaticStrings.getStarted,
                    onTap: () {
                      Get.offAllNamed(AppRoute.signIn);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
