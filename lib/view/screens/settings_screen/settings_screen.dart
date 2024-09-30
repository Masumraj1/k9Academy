import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/authentication/authentication_controller/authentication_controller.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});

 final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  ///====================================Delete Account=============================
  void showDialogBox(BuildContext context) {
    Get.dialog(
      Obx(
         () {
          return AlertDialog(
            backgroundColor: AppColors.blackyDarkHover,
            content: SizedBox(
              height: 300.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const CustomImage(
                            imageSrc: AppIcons.x,
                            imageType: ImageType.svg,
                          ))
                    ],
                  ),
                  const CustomText(
                    text: AppStaticStrings.wantToDeleteAccount,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueNormal,
                    bottom: 10,
                  ),
                  const CustomText(
                    textAlign: TextAlign.start,
                    text: AppStaticStrings.pleaseConfirmYourPassword,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightNormalHover,
                    bottom: 16,
                    maxLines: 2,
                  ),
                  const CustomText(
                    top: 16,
                    text: "Password",
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightNormalHover,
                    bottom: 16,
                  ),

                  ///======================================Password Field==================
                   CustomTextField(
                    textEditingController: authenticationController.signupPasswordController,
                    hintText: "password",
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      authenticationController.isDeleteLoading.value?
                          const CustomLoader():
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.redNormal),
                          ),
                          onPressed: () {
                            authenticationController.deleteAccount();
                          },
                          child: CustomText(
                            text: AppStaticStrings.delete,
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight
                                .w600, // Make sure the text color contrasts with the button color
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.blueNormal),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: CustomText(
                            text: AppStaticStrings.cancel,
                            color: AppColors.lightNormal,
                            fontSize: 14.sp,
                            fontWeight: FontWeight
                                .w600, // Make sure the text color contrasts with the button color
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackyDarkHover,

      ///<<<<<========================================settings AppBar ============================
      appBar: AppBar(
        backgroundColor: AppColors.blackyDarker,
        centerTitle: true,
        title: CustomText(
          text: AppStaticStrings.settings,
          color: AppColors.lightNormal,
          fontSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                const CustomImage(
                  imageSrc: AppIcons.lock,
                  imageType: ImageType.svg,
                ),
                SizedBox(
                  width: 8.w,
                ),

                ///<<<<<========================================Change password Button ============================
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.changePasswordScreen);
                  },
                  child: CustomText(
                    text: AppStaticStrings.changePassword,
                    color: AppColors.lightNormal,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),

            ///<<<<<========================================Delete Account Button ============================
            GestureDetector(
              onTap: () {
                showDialogBox(context);
              },
              child: Row(
                children: [
                  const CustomImage(
                    imageSrc: AppIcons.trash,
                    imageType: ImageType.svg,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  CustomText(
                    text: AppStaticStrings.deleteAccount,
                    color: AppColors.lightNormal,
                    fontSize: 16.sp,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
