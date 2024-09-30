import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/my_package/controller/my_package.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';

import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';

import '../../../utils/app_colors/app_colors.dart';

class MyPackageScreen extends StatelessWidget {
  MyPackageScreen({super.key});

  final MyPackageController myPackageController =
      Get.find<MyPackageController>();

  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (myPackageController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(onTap: () {
            myPackageController.getMyPackage();
          });
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              myPackageController.getMyPackage();
            },
          );
        case Status.completed:
          var data = myPackageController.myPackage.value;
          return generalController.hasSubsCription.value
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.blackyNormalActive,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              "${AppStaticStrings.endDate}: ${DateConverter.monthDateYear(data.endDate ?? DateTime.now())}",
                          color: AppColors.blueLightActive,
                          fontSize: 14.sp,
                          bottom: 8,
                          top: 8,
                        ),
                        CustomText(
                          text: data.planId?.packageName ?? "",
                          color: AppColors.lightNormalHover,
                          fontSize: 14.sp,
                          bottom: 8,
                          top: 8,
                        ),
                        CustomText(
                          text:
                              "${AppStaticStrings.price}: \$${data.planId?.packagePrice ?? 0.0}",
                          color: AppColors.lightNormalHover,
                          fontSize: 14.sp,
                          bottom: 8,
                          top: 8,
                        ),
                        const Divider(),

                        //==================== Feature1 [Traning Video] ======================

                        if (data.planId?.trainingVideo?.status == true)
                          Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.checkDone,
                                size: 30.sp,
                              ),
                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                text: data.planId?.trainingVideo?.title ?? "",
                                left: 10,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 10.w,
                        ),

                        //==================== Feature2 [Community Group] ======================

                        if (data.planId?.communityGroup?.status == true)
                          Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.checkDone,
                                size: 30.sp,
                              ),
                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                text: data.planId?.communityGroup?.title ?? "",
                                left: 10,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 10.w,
                        ),

                        //==================== Feature3 [VideoLesson] ======================

                        if (data.planId?.videoLesson?.status == true)
                          Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.checkDone,
                                size: 30.sp,
                              ),
                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                text: data.planId?.videoLesson?.title ?? "",
                                left: 10,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 10.w,
                        ),

                        //==================== Feature4 [Chat] ======================

                        if (data.planId?.chat?.status == true)
                          Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.checkDone,
                                size: 30.sp,
                              ),
                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                text: data.planId?.chat?.title ?? "",
                                left: 10,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 10.w,
                        ),

                        //==================== Feature5 [Program] ======================

                        if (data.planId?.program?.status == true)
                          Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.checkDone,
                                size: 30.sp,
                              ),
                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                text: data.planId?.program?.title ?? "",
                                left: 10,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 10.w,
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 100),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.4,
                      decoration: BoxDecoration(
                          color: AppColors.blackyNormalActive,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const CustomText(
                            text: AppStaticStrings.youDontHaveAny,
                            bottom: 30,
                          ),

                          ///=================================Subscription Button ================
                          CustomButton(
                            fillColor: AppColors.redNormal,
                            width: MediaQuery.of(context).size.width / 2,
                            onTap: () {
                              Get.toNamed(AppRoute.subscription);
                            },
                            title: AppStaticStrings.subscriptionNow,
                          )
                        ],
                      ),
                    ),
                  ),
                );
      }
    });
  }
}
