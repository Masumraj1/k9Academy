import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/authentication/authentication_controller/authentication_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({super.key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  final formKey = GlobalKey<FormState>();
  int _secondsRemaining = 180;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 44.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  ///<=================================Title Text=====================================>
                  const Center(
                      child: CustomText(
                    color: AppColors.blueNormal,
                    text: AppStaticStrings.checkYourEmail,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
                  const CustomText(
                    text: AppStaticStrings.wehaveSendAnOTP,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    maxLines: 3,
                    top: 8,
                  ),

                  SizedBox(
                    height: 68.h,
                  ),

                  ///<======================================Pin Code Field============================>

                  PinCodeTextField(
                    textStyle: const TextStyle(color: AppColors.lightActive),
                    keyboardType: TextInputType.phone,
                    autoDisposeControllers: false,
                    cursorColor: AppColors.blackyDarkActive,
                    appContext: (context),
                    controller: authenticationController.pinController,
                    onCompleted: (value) {
                      authenticationController.activationCode = value;
                    },
                    validator: (value) {
                      if (value!.length == 6) {
                        return null; // Input is valid
                      } else {
                        return "Please enter a 6-digit OTP code"; // Input is invalid
                      }
                    },
                    autoFocus: true,
                    pinTheme: PinTheme(
                      disabledColor: Colors.transparent,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 49.h,
                      fieldWidth: 47,
                      activeFillColor: AppColors.lightDarkActive,
                      selectedFillColor: AppColors.lightDarkActive,
                      inactiveFillColor: AppColors.lightDarkActive,
                      borderWidth: 0.5,
                      errorBorderColor: Colors.red,
                      activeBorderWidth: 0.8,
                      selectedColor: AppColors.lightDarkActive,
                      inactiveColor: AppColors.lightDarkActive,
                      activeColor: AppColors.lightDarkActive,
                    ),
                    length: 6,
                    enableActiveFill: true,
                  ),

                  SizedBox(
                    height: 28.h,
                  ),

                  ///<==============================Resend Button=============================>

                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (_secondsRemaining == 0) {
                          _secondsRemaining = 180;
                          startTimer();
                          authenticationController.resentUser().then((value) {
                            if (value == false) {
                              setState(() {
                                _timer.cancel();
                                _secondsRemaining = 0;
                              });
                            }
                          });
                        }
                      },
                      child: CustomText(
                          text: _secondsRemaining == 0
                              ? "Resend OTP".tr
                              : "Resend OTP $_secondsRemaining",
                          color: AppColors.lightDark,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  ///<================================== Verify Button ===========================>
                  authenticationController.isOtpLoading.value
                      ? const CustomLoader()
                      : CustomButton(
                          fillColor: AppColors.redNormal,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authenticationController.signUpVerifyOTP();
                            }
                          },
                          title: AppStaticStrings.verifyCode,
                        ),
                ],
              ),
            ));
      }),
    );
  }
}
