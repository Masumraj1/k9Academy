import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/helper/shared_prefe/shared_prefe.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/app_img/app_img.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_widgets/custom_widgets.dart';

import '../../../../utils/static_strings/static_strings.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});

  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 64),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
        color: AppColors.lightDarker,
      ),
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        children: [
          ///================================ APP LOGO ==============================///
          CustomImage(
            size: 100,
            imageSrc: AppImages.logo,
            imageType: ImageType.png,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    ///====================== My Profile ======================>

                    customWidget.customRow(
                        image: AppIcons.myProfile,
                        onTap: () {
                          Get.toNamed(AppRoute.myProfileScreen);
                        },
                        title: AppStaticStrings.myProfile),

                    ///======================= Settings =========================

                    customWidget.customRow(
                        image: AppIcons.settings,
                        onTap: () {
                          Get.toNamed(AppRoute.settingsScreen);
                        },
                        title: AppStaticStrings.settings),

                    ///=========================Buy package======================
                    customWidget.customRow(
                        image: AppIcons.buyPackage,
                        onTap: () {
                          Get.toNamed(AppRoute.subscription);
                        },
                        title: AppStaticStrings.buyPackages),

                    const Divider(),

                    ///======================= About Us ========================

                    customWidget.customRow(
                        image: AppIcons.aboutUS,
                        onTap: () {
                          Get.toNamed(AppRoute.aboutUs);
                        },
                        title: AppStaticStrings.aboutUs),

                    ///======================= FAQ ========================

                    customWidget.customRow(
                        image: AppIcons.faq,
                        onTap: () {
                          Get.toNamed(AppRoute.fAQScreen);
                        },
                        title: AppStaticStrings.fAQ),

                    ///======================= Privacy Policy ========================

                    customWidget.customRow(
                        image: AppIcons.privacyPolicy,
                        onTap: () {
                          Get.toNamed(AppRoute.privacyPolicy);
                        },
                        title: AppStaticStrings.privacyPolicy),

                    ///======================= Terms and Condition ========================

                    customWidget.customRow(
                        image: AppIcons.terms,
                        onTap: () {
                          Get.toNamed(AppRoute.termsCondition);
                        },
                        title: AppStaticStrings.termsConditions),

                    const Divider(),

                    ///======================= Log Out ========================

                    customWidget.customRow(
                        image: AppIcons.logOut,
                        onTap: () {
                          SharePrefsHelper.setBool(
                              AppConstants.isRememberMe, false);

                          SharePrefsHelper.remove(AppConstants.bearerToken);
                          SharePrefsHelper.remove(AppConstants.profileID);
                          SharePrefsHelper.remove(AppConstants.conversationID);
                          SharePrefsHelper.remove(AppConstants.hasSubsCription);

                          Get.offAllNamed(AppRoute.signIn);
                        },
                        title: AppStaticStrings.logOut),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
