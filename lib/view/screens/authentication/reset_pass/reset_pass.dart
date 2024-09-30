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

class ResetPass extends StatelessWidget {
  ResetPass({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthenticationController authenticationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
       () {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///<=================================Title Text=====================================>
                const Center(
                    child: CustomText(
                  color: AppColors.blueNormal,
                  text: AppStaticStrings.setNewPassword,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
                const CustomText(
                  text:
                      "Create a new password. Ensure it differs from previous ones for security",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  maxLines: 3,
                  top: 8,
                ),

                SizedBox(
                  height: 56.h,
                ),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///<============================== New Password section====================================>
                      CustomText(
                        text: "New Password",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 16.h,
                        top: 16.h,
                      ),

                      CustomTextField(
                        textEditingController:
                            authenticationController.newPasswordController,
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
                        textInputAction: TextInputAction.next,
                        isPassword: true,
                        hintText: AppStaticStrings.password,
                      ),

                      ///<==============================Confirm Password section====================================>
                      CustomText(
                        text: AppStaticStrings.confirmPassword,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 16.h,
                        top: 24.h,
                      ),

                      CustomTextField(
                        textEditingController:
                            authenticationController.confirmPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppStaticStrings.fieldCantBeEmpty;
                          }

                          else if (authenticationController.newPasswordController.text !=
                              authenticationController.confirmPasswordController.text) {
                            return "Password should be match";
                          }
                          return null;
                        },
                        //  textEditingController: controller.confirmPassController,
                        textInputAction: TextInputAction.done,
                        isPassword: true,
                        hintText: AppStaticStrings.confirmPassword,
                      ),

                      SizedBox(
                        height: 23.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 56.h,
                ),

                ///========================= Update Pass Button ========================
                authenticationController.isResetLoading.value?
                    const CustomLoader():
                CustomButton(
                  fillColor: AppColors.redNormal,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      authenticationController.resetPassword();
                    }
                  },
                  title: AppStaticStrings.updatePassword,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
