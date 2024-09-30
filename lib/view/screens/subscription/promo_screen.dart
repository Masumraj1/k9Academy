import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/screens/subscription/subscription_controller/subscription_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';

class PromoScreen extends StatelessWidget {
  PromoScreen({super.key});
  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (subscriptionController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              subscriptionController.getSubscription();
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              subscriptionController.getSubscription();
            },
          );
        case Status.completed:
          var data = subscriptionController.promoData.value;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            backgroundColor: AppColors.blackyDarker.withOpacity(0.3),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: AppStaticStrings.enterYourPromocodeHere,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  bottom: 30,
                ),

                //==================== Feature1 [Traning Video] ======================

                if (data.trainingVideo?.status == true)
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.checkDone,
                        size: 30.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        text: data.trainingVideo?.title ?? "",
                        left: 10,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10.h,
                ),

                //==================== Feature2 [Community Group] ======================

                if (data.communityGroup?.status == true)
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.checkDone,
                        size: 30.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        text: data.communityGroup?.title ?? "",
                        left: 10,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10.h,
                ),

                //==================== Feature3 [VideoLesson] ======================

                if (data.videoLesson?.status == true)
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.checkDone,
                        size: 30.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        text: data.videoLesson?.title ?? "",
                        left: 10,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10.h,
                ),

                //==================== Feature4 [Chat] ======================

                if (data.chat?.status == true)
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.checkDone,
                        size: 30.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        text: data.chat?.title ?? "",
                        left: 10,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10.h,
                ),

                //==================== Feature5 [Program] ======================

                if (data.program?.status == true)
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.checkDone,
                        size: 30.sp,
                      ),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          text: data.program?.title ?? "",
                          left: 10,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),

                ///
                /////
                SizedBox(
                  height: 15.h,
                ),

                ///========================== Promo code input field ===========================

                CustomTextField(
                  inputTextStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  hintText: AppStaticStrings.enterYourPromocodeHere,
                  textEditingController: subscriptionController.promoController,
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///========================== Promo code Cancel ===========================

                CustomButton(
                  onTap: () {
                    subscriptionController.isPromoCode.value =
                        !subscriptionController.isPromoCode.value;

                    subscriptionController.isPromoCode.refresh();
                    navigator?.pop();
                  },
                  title: AppStaticStrings.cancel,
                  fillColor: AppColors.redNormalHover,
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///========================== Promo code Confirm ===========================

                CustomButton(
                  onTap: () {
                    subscriptionController.promoCodeApply();
                  },
                  title: AppStaticStrings.confirm,
                  fillColor: AppColors.blueNormal,
                ),
              ],
            ),
          );
      }
    });
  }
}
