import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/faq_screen/controller/faq_controller.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';

import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/expanded_animation/expanded_animation.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});

  final FaqController controller = Get.find<FaqController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackyDarkHover,
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: AppStaticStrings.fAQ,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  controller.getFaq();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getFaq();
                },
              );

            case Status.completed:
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: List.generate(controller.faqList.length, (index) {
                    var data = controller.faqList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Column(
                        children: [
                          ///==================== Question Design =====================
                          GestureDetector(
                            onTap: () {
                              if (controller.selectedFqw.value == index) {
                                controller.selectedFqw.value = 100000;
                              } else {
                                controller.selectedFqw.value = index;
                              }

                              controller.selectedFqw.refresh();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.blackyNormalActive,
                                  border:
                                      Border.all(color: AppColors.blueNormal)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: CustomText(
                                    textAlign: TextAlign.left,
                                    text: data.question ?? "",
                                    fontWeight: FontWeight.w500,
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        if (controller.selectedFqw.value ==
                                            index) {
                                          controller.selectedFqw.value = 100000;
                                        } else {
                                          controller.selectedFqw.value = index;
                                        }

                                        controller.selectedFqw.refresh();
                                      },
                                      icon: controller.selectedFqw.value ==
                                              index
                                          ? const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: AppColors.blueNormal,
                                            )
                                          : const Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              color: AppColors.blueNormal,
                                            ))
                                ],
                              ),
                            ),
                          ),

                          ///==================== Ans Design =====================

                          index == controller.selectedFqw.value
                              ? CustomExpandedSection(
                                  expand: index == controller.selectedFqw.value
                                      ? true
                                      : false,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    padding: EdgeInsets.all(8.r),
                                    alignment: Alignment.center,
                                    height: 100.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightDarkActive,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      text: data.answer ?? "",
                                      maxLines: 6,
                                    ),
                                  ))
                              : const SizedBox()
                        ],
                      ),
                    );
                  }),
                ),
              );
          }
        }));
  }
}
