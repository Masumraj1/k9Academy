import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/authentication/authentication_controller/authentication_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackyDarkHover,

      ///<<<<========================================Change Password AppBar======================================
      appBar: AppBar(
        title: CustomText(
          text: AppStaticStrings.changePassword,
          color: AppColors.lightNormal,
          fontSize: 18.sp,
        ),
        backgroundColor: AppColors.blackyDarker,
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: AppStaticStrings.oldPassword,
                    color: AppColors.lightNormal,
                    fontSize: 16.sp,
                    bottom: 10,
                  ),

                  ///<<<<========================================Current Password Field======================================
                  CustomTextField(
                    hintText: AppStaticStrings.password,
                    textEditingController:
                    authenticationController.oldPasswordController,
                    keyboardType: TextInputType.name,
                    isPassword: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppStaticStrings.fieldCantBeEmpty;
                      } else if (value.length < 8 ||
                          !AppStaticStrings.passRegexp.hasMatch(value)) {
                        return AppStaticStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),

                  CustomText(
                    text: AppStaticStrings.newPassword,
                    color: AppColors.lightNormal,
                    fontSize: 16.sp,
                    bottom: 10,
                    top: 27,
                  ),

                  ///<<<<========================================NewPassword Field======================================
                  CustomTextField(
                    isPassword: true,
                    textEditingController:
                    authenticationController.newPasswordController,
                    keyboardType: TextInputType.name,
                    hintText: AppStaticStrings.password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppStaticStrings.fieldCantBeEmpty;
                      } else if (value.length < 8 ||
                          !AppStaticStrings.passRegexp.hasMatch(value)) {
                        return AppStaticStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),

                  CustomText(
                    text: AppStaticStrings.confirmPassword,
                    color: AppColors.lightNormal,
                    fontSize: 16.sp,
                    bottom: 10,
                    top: 27,
                  ),

                  ///<<<<========================================Confirm Password Field======================================
                  CustomTextField(
                    textEditingController:
                    authenticationController.confirmPasswordController,
                    keyboardType: TextInputType.name,
                    hintText: AppStaticStrings.password,
                    isPassword: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppStaticStrings.fieldCantBeEmpty;
                      } else if (value !=
                          authenticationController.newPasswordController.text) {
                        return " Password should match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),

                  ///<<<<========================================Save And Update Button======================================
                  authenticationController.isChangeLoading.value?
                     const CustomLoader():
                  Center(
                    child: CustomButton(
                      fillColor: AppColors.redNormal,
                      width: 194,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authenticationController.changePassword();
                        }
                      },
                      title: AppStaticStrings.changePassword,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
