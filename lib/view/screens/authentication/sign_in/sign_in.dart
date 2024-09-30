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

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                const CustomText(
                  text: AppStaticStrings.welcomeBack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.left,
                  bottom: 20,
                ),

                const CustomText(
                  text: AppStaticStrings.pleaseEnterYour,
                  maxLines: 3,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  bottom: 10,
                ),
                const Divider(),

                ///============================= Form ============================
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStaticStrings.email,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          bottom: 16.h,
                          top: 30.h,
                        ),

                        ///<=======================================Email section======================================>

                        CustomTextField(
                          textEditingController:
                              authenticationController.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStaticStrings.enterValidEmail;
                            } else if (!AppStaticStrings.emailRegexp.hasMatch(
                                authenticationController
                                    .emailController.text)) {
                              return AppStaticStrings.enterValidEmail;
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          // textEditingController: controller.signInEmail,
                          hintText: AppStaticStrings.enterYourEmail,
                        ),

                        ///<=======================================Password section======================================>

                        CustomText(
                          text: AppStaticStrings.password,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          top: 16.h,
                          bottom: 16.h,
                        ),
                        CustomTextField(
                          textEditingController:
                              authenticationController.passwordController,
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
                          textInputAction: TextInputAction.done,
                          isPassword: true,
                          hintText: AppStaticStrings.enterYourPassword,
                        ),
                      ],
                    )),

                ///=============================== Forgot Password ==============================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: authenticationController.isRemember.value,
                            checkColor: AppColors.lightDarkActive,
                            activeColor: AppColors.redLightActive,
                            focusColor: Colors.red,
                            onChanged: (value) {
                              authenticationController.toggleRemember();
                            }),
                        const CustomText(
                          text: AppStaticStrings.rememberMe,
                          color: AppColors.light,
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.forgotPass);
                        },
                        child: const CustomText(
                            color: AppColors.blueNormal,
                            text: AppStaticStrings.forgotPassWord)),
                  ],
                ),

                ///<============================== Login Button ====================================>

                SizedBox(
                  height: 45.h,
                ),
                authenticationController.isSignInLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        fillColor: AppColors.redNormal,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            authenticationController.signInUser();
                          }
                        },
                        title: AppStaticStrings.logIn,
                      ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: const Divider(),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: AppStaticStrings.dontHaveAnyAccount),

                    ///========================= Sign Up Button ========================
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.signUp);
                        },
                        child: const CustomText(
                            color: AppColors.blueNormal,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            text: AppStaticStrings.signUp))
                  ],
                )
              ],
            ),
          ),
        ));
      }),
    );
  }
}
