import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/authentication/authentication_controller/authentication_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),

              ///<==================================Title text===============================>

              const Center(
                  child: CustomText(
                text: AppStaticStrings.createAccount,
                textAlign: TextAlign.center,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///<===================================Name section============================>
                    SizedBox(
                      height: 31.h,
                    ),

                    CustomText(
                      text: AppStaticStrings.fullName,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                    ),

                    CustomTextField(
                      textEditingController:
                          authenticationController.fullNameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStaticStrings.enterAValidName;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      //   textEditingController: controller.fullNameSignUp,
                      hintText: AppStaticStrings.fullName,
                    ),

                    ///<===========================Email section======================================>

                    CustomText(
                      text: AppStaticStrings.email,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                      top: 8.h,
                    ),
                    CustomTextField(
                      textEditingController:
                          authenticationController.signupEmailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStaticStrings.enterValidEmail;
                        } else if (!AppStaticStrings.emailRegexp.hasMatch(
                            authenticationController
                                .signupEmailController.text)) {
                          return AppStaticStrings.enterValidEmail;
                        } else {
                          return null;
                        }
                      },

                      textInputAction: TextInputAction.next,
                      // textEditingController: controller.emailSignUp,
                      hintText: AppStaticStrings.email,
                    ),

                    ///<=================================phone number section=============================>
                    CustomText(
                      text: AppStaticStrings.phoneNumber,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                      top: 8.h,
                    ),

                    CustomTextField(
                      textEditingController:
                          authenticationController.phoneNumberController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                      //textEditingController: controller.phoneSignUp,
                      textInputAction: TextInputAction.next,
                      hintText: AppStaticStrings.phoneNumber,
                      keyboardType: TextInputType.phone,
                    ),

                    ///<==============================Password section====================================>
                    CustomText(
                      text: AppStaticStrings.password,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                      top: 8.h,
                    ),

                    CustomTextField(
                      textEditingController:
                          authenticationController.signupPasswordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.passWordMustBeAtLeast;
                        } else if (value.length < 8 ||
                            !AppStaticStrings.passRegexp.hasMatch(value)) {
                          return AppStaticStrings.passwordLengthAndContain;
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      //textEditingController: controller.passSignUp,
                      isPassword: true,
                      hintText: AppStaticStrings.password,
                    ),

                    ///<==========================Confirm password========================================>
                    CustomText(
                      text: AppStaticStrings.confirmPassword,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                      top: 8.h,
                    ),

                    CustomTextField(
                      textEditingController:
                          authenticationController.confirmPasswordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else if (value !=
                            authenticationController
                                .signupPasswordController.text) {
                          return "Password should match";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      isPassword: true,
                      hintText: AppStaticStrings.confirmPassword,
                    ),

                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),

              ///<==============================================Sign Up Button==========================================>
              authenticationController.isSignUpLoading.value
                  ? const CustomLoader()
                  : CustomButton(
                      fillColor: AppColors.redNormal,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authenticationController.signUpUser();
                        }
                      },
                      title: AppStaticStrings.signUp,
                    ),

              SizedBox(
                height: 32.h,
              ),

              ///<=================================Terms and Condition, Privacy Policy======================================>

              RichText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "By clicking sign up you certify that you agree to our ",
                      style: TextStyle(
                          color: AppColors.light,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.sp),
                    ),
                    TextSpan(
                      text: AppStaticStrings.privacyPolicy,
                      style: TextStyle(
                          color: AppColors.blueNormal,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoute.privacyPolicy);
                        },
                    ),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(
                          color: AppColors.light,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: AppStaticStrings.terms,
                      style: TextStyle(
                          color: AppColors.blueNormal,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoute.termsCondition);
                        },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 16.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: AppStaticStrings.alreadyHaveAnAccount,

                    /// <==============================Sign in text==============================>
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(AppRoute.signInScreen);
                      navigator!.pop();
                    },
                    child: const CustomText(
                      color: AppColors.blueNormal,
                      text: AppStaticStrings.logIn,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 18.h,
              ),
            ],
          ),
        ),
      );
    }));
  }
}
