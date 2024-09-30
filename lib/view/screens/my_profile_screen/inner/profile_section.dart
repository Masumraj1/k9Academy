import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/my_profile_screen/profile_controller/profile_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:k9academy/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:k9academy/view/widgets/error/genarel_error.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  final CustomWidgets customWidgets = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return profileController.isAddItem.value
                  ? Row(
                      children: [
                        const SizedBox(),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            profileController.isAddItem.value =
                                !profileController.isAddItem.value;
                          },

                          ///=======================Edit Pencil===========================
                          child:
                              const CustomImage(imageSrc: AppIcons.editPencil),
                        ),
                      ],
                    )

                  ///========================================Edit Profile Section====================
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///==================================Name Field=============================
                        customWidgets.customTitleAndTextField(
                            text: AppStaticStrings.name,
                            hintText: AppStaticStrings.enterYourName,
                            controller: profileController.nameController),

                        ///=====================================Email field ========================

                        CustomText(
                          top: 7,
                          bottom: 12,
                          text: AppStaticStrings.email,
                          fontSize: 16.sp,
                          color: AppColors.lightActive,
                        ),
                        CustomTextField(
                          readOnly: true,
                          textEditingController:
                              profileController.emailController,
                          hintText: AppStaticStrings.enterYourEmail,
                        ),

                        ///=====================================number field =======================
                        customWidgets.customTitleAndTextField(
                            text: AppStaticStrings.contactNo,
                            hintText: AppStaticStrings.enterYourContaNo,
                            controller: profileController.contactController),

                        ///=========================================Date of field=====================
                        CustomText(
                          top: 7,
                          bottom: 12,
                          text: AppStaticStrings.dateOfBirth,
                          fontSize: 16.sp,
                          color: AppColors.lightActive,
                        ),
                        CustomTextField(
                          readOnly: true,
                          textEditingController:
                              profileController.dateController.value,
                          hintText: DateConverter.formatDateYearMonth(
                              profileController.newSelectedDate.value),
                          suffixIcon: IconButton(
                            onPressed: () {
                              profileController.calenderShow(
                                  context, profileController.newSelectedDate);
                            },
                            icon: const Icon(
                              Icons.date_range,
                              size: 30,
                              color: AppColors.lightActive,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.w,
                        ),

                        ///==================================Age field=============================
                        customWidgets.customTitleAndTextField(
                            text: AppStaticStrings.age,
                            hintText: AppStaticStrings.enterYourAge,
                            controller: profileController.ageController),

                        ///==================================Gender field============================
                        customWidgets.customTitleAndTextField(
                            text: AppStaticStrings.gender,
                            hintText: AppStaticStrings.enterYourGender,
                            controller: profileController.genderController),
                        SizedBox(
                          height: 10.h,
                        ),

                        ///===================================== Save button =====================
                        CustomButton(
                          fillColor: AppColors.redNormal,
                          onTap: () {
                            profileController.multipartRequest();
                            // print("${profileController.newSelectedDate.value}");
                          },
                          title: AppStaticStrings.saveChange,
                        ),
                      ],
                    );
            }),
          ),
          Obx(() {
            var data = profileController.profileModel.value.userInfo;
            switch (profileController.rxRequestStatus.value) {
              case Status.loading:
                return const CustomLoader();
              case Status.internetError:
                return const CustomLoader();
              case Status.error:
                return GeneralErrorScreen(
                  onTap: () {
                    profileController.getProfile();
                  },
                );

              case Status.completed:
                return profileController.isAddItem.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///=====================================Name ===========================
                            GestureDetector(
                              onTap: () {
                                profileController.getProfile();
                              },
                              child: CustomText(
                                text: AppStaticStrings.name,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                bottom: 5,
                              ),
                            ),

                            CustomText(
                              text: data?.name ?? "",
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightNormalHover,
                              fontSize: 14.sp,
                              bottom: 5,
                            ),

                            ///=====================================Email ===========================
                            CustomText(
                              text: AppStaticStrings.email,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              bottom: 5,
                            ),
                            CustomText(
                              text: data?.email ?? "",
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightNormalHover,
                              fontSize: 14.sp,
                              bottom: 5,
                            ),

                            ///=====================================Contact Number ===========================
                            CustomText(
                              text: AppStaticStrings.contactNo,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              bottom: 5,
                            ),
                            CustomText(
                              text: data?.phoneNumber ?? "",
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightNormalHover,
                              fontSize: 14.sp,
                              bottom: 5,
                            ),

                            ///=====================================Date of Birth ===========================
                            CustomText(
                              text: AppStaticStrings.dateOfBirth,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              bottom: 5,
                            ),
                            CustomText(
                              text: DateConverter.formatDetails(
                                  data?.dateOfBirth ?? ""),
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightNormalHover,
                              fontSize: 14.sp,
                              bottom: 5,
                            ),

                            ///=====================================Age ===========================
                            CustomText(
                              text: AppStaticStrings.age,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              bottom: 5,
                            ),
                            CustomText(
                              text: data?.age ?? "",
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightNormalHover,
                              fontSize: 14.sp,
                              bottom: 5,
                            ),

                            ///=====================================Gender ===========================
                            CustomText(
                              text: AppStaticStrings.gender,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              bottom: 5,
                            ),
                            CustomText(
                              text: data?.gender ?? "",
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightNormalHover,
                              fontSize: 14.sp,
                              bottom: 5,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
