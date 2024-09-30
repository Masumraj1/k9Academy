import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/app_img/app_img.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/screens/subscription/promo_screen.dart';
import 'package:k9academy/view/screens/subscription/subscription_controller/subscription_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/error/genarel_error.dart';

class Subscription extends StatelessWidget {
  Subscription({super.key});

  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();

  void showDialogBox(BuildContext context, int index) {
    Get.dialog(barrierDismissible: false, PromoScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppStaticStrings.subscriptionPlan,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        switch (subscriptionController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(
              onTap: () {
                //  messageController.getMessageList();
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
            return Stack(
              children: [
                ///=====================================BackGround Images=====================
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AppImages.packageBG),
                    ),
                  ),
                ),
                if (!subscriptionController.isPromoCode.value)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          subscriptionController.subscriptionLists.length,
                          (index) {
                        var data =
                            subscriptionController.subscriptionLists[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            width: MediaQuery.of(context).size.width / 1.3,
                            decoration: BoxDecoration(
                              color: AppColors.blackyDarker.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///===========================Title================
                                CustomText(
                                  text: data.packageName ?? "",
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                  bottom: 16,
                                  top: 20,
                                ),

                                ///========================== Amount ==========================

                                CustomText(
                                  text: "\$${data.packagePrice.toString()}",
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                  bottom: 16,
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

                                SizedBox(
                                  height: 15.h,
                                ),

                                ///================================ Make Payment Button ======================
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomButton(
                                    fillColor: AppColors.redNormal,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    onTap: () {
                                      subscriptionController.makePayment(
                                          amount: data.packagePrice.toString(),
                                          packageID: data.id ?? "");
                                    },
                                    title: AppStaticStrings.makePayment,
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///=====================================Have you Promo Code=============
                        CustomText(
                          text: AppStaticStrings.haveYourPromoCode,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.light,
                          bottom: 20,
                        ),

                        ///===================================Use Promo  Code button==============

                        CustomButton(
                          fillColor: AppColors.blueNormal,
                          width: MediaQuery.of(context).size.width / 2,
                          onTap: () {
                            subscriptionController.isPromoCode.value =
                                !subscriptionController.isPromoCode.value;

                            subscriptionController.isPromoCode.refresh();
                            showDialogBox(
                                context, 0); // Pass the correct index here
                          },
                          title: AppStaticStrings.usePromoCode,
                        ),

                        ///=============================Skip Button========================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.homeScreen);
                          },
                          child: CustomText(
                            text: "Skip",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.light,
                            bottom: 20,
                            top: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}
