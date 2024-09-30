import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:k9academy/helper/network_img/network_img.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';

class CustomWidgets {
  ///=========================Training Programs details card design in custom================
  Widget customTrainingDetailsCard(
          {required String image,
          required String text,
          required VoidCallback onTap}) =>
      GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 10, top: 20, left: 20, right: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.lightDarker),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CustomNetworkImage(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    imageUrl: image,
                    height: 148.w,
                    width: 144.h,
                  ),
                  Expanded(
                    child: CustomText(
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      left: 15,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      text: text,
                      top: 13,
                    ),
                  ),
                ],
              ),
            ),
          ));

  ///=========================== CustomTraining Card=============================
  Widget customTrainingCard({
    required String image,
    required String text,
  }) =>
      Container(
        width: 219.h,
        height: 238.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightDarker),
        child: Padding(
            padding:
                const EdgeInsets.only(bottom: 20, left: 8, right: 8, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(32)),
                  imageUrl: image,
                  height: 178.w,
                  width: 203.h,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          maxLines: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          text: text,
                          top: 13,
                        ),
                      ),
                      SizedBox(
                        width: 14.h,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: CustomImage(
                          imageSrc: AppIcons.dogPow,
                          imageType: ImageType.svg,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      );

  ///===============================Custom Side Drawer Row=============================
  Widget customRow(
          {required String image,
          required String title,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              CustomImage(
                size: 18.r,
                imageSrc: image,
              ),
              CustomText(
                color: AppColors.lightNormalActive,
                left: 16.w,
                text: title,
                fontSize: 12.w,
              )
            ],
          ),
        ),
      );

  ///=================================EditProfileCustomField===================================
  Widget customTitleAndTextField({
    required String text,
    required String hintText,
    required TextEditingController controller,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              top: 7,
              text: text,
              bottom: 10,
              color: AppColors.lightActive,
              fontSize: 16.sp,
            ),
            CustomTextField(
              textEditingController: controller,
              hintText: hintText,
            ),
          ],
        ),
      );

  ///====================================Custom Community Post Details ===========================
}
