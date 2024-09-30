import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/network_img/network_img.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/my_package/my_package.dart';
import 'package:k9academy/view/screens/my_profile_screen/inner/tab_bar_post_screen.dart';
import 'package:k9academy/view/screens/my_profile_screen/profile_controller/profile_controller.dart';
import 'package:k9academy/view/screens/schedule_screen/schedule_screen.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/nav_bar/nav_bar.dart';

import 'inner/profile_section.dart';
import 'inner/tab_bar_widgets.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  ///=================================CoverImage Widget===================================
  Widget buildCoverImage() => Obx(
        () => Container(
          color: Colors.grey,
          child: Stack(
            children: [
              profileController.coverImage.isNotEmpty
                  ? Image.file(
                      File(profileController.coverImage.value),
                      width: double.infinity,
                      height: 171.h,
                      fit: BoxFit.cover,
                    )
                  : CustomNetworkImage(
                      imageUrl: (profileController
                                  .profileModel.value.userInfo?.coverImage
                                  ?.startsWith('https') ??
                              false)
                          ? profileController
                                  .profileModel.value.userInfo?.coverImage ??
                              ""
                          : "${ApiUrl.baseUrl}${profileController.profileModel.value.userInfo?.coverImage ?? ""}",
                      width: double.infinity,
                      height: 171.h,
                    ),
              Positioned(
                right: 5.w,
                top: 10.h,
                child: GestureDetector(
                  onTap: () {
                    profileController.selectCoverImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: profileController.isAddItem.value
                        ? const SizedBox()
                        : const CustomImage(imageSrc: AppIcons.cemera),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 10.h,
              //   right: 90.w,
              //   child: CustomText(
              //     text:
              //         profileController.profileModel.value.userInfo?.name ?? "",
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
            ],
          ),
        ),
      );

  ///=================================profileImage Widget===================================
  final double profileHeight = 120.h;

  Widget buildProfileImage() => Positioned(
        bottom: -10.h,
        left: 10.w,
        child: Obx(
          () {
            return profileController.image.isNotEmpty
                ? Stack(
                    alignment: Alignment.bottomRight,
                    clipBehavior: Clip.none,
                    fit: StackFit.loose,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(profileController.image.value),
                          height: profileHeight,
                          width: profileHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (!profileController.isAddItem.value)
                        InkWell(
                            onTap: () {
                              profileController.selectImage();
                            },
                            child:
                                const CustomImage(imageSrc: AppIcons.cemera)),
                    ],
                  )
                : Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CustomNetworkImage(
                        boxShape: BoxShape.circle,
                        imageUrl: (profileController
                                    .profileModel.value.userInfo?.profileImage
                                    ?.startsWith('https') ??
                                false)
                            ? profileController.profileModel.value.userInfo
                                    ?.profileImage ??
                                ""
                            : "${ApiUrl.baseUrl}${profileController.profileModel.value.userInfo?.profileImage ?? ""}",
                        height: profileHeight,
                        width: profileHeight,
                      ),
                      if (!profileController.isAddItem.value)
                        InkWell(
                            onTap: () {
                              profileController.selectImage();
                            },
                            child:
                                const CustomImage(imageSrc: AppIcons.cemera)),
                    ],
                  );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),
      backgroundColor: AppColors.blackyDarkHover,
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: AppStaticStrings.myProfile,
          color: AppColors.lightNormal,
          fontSize: 18.sp,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                buildCoverImage(),
                buildProfileImage(),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          ///================================= Inner 4 TabBar Widgets ===================================
          TabBarWidgets(profileController: profileController),
          const Divider(),
          Obx(() {
            return Expanded(
              child: IndexedStack(
                index: profileController.selectedIndex.value,
                children: [
                  ProfileSection(
                    profileController: profileController,
                  ),
                  TabBarPostScreen(),
                  MyPackageScreen(),
                  ScheduleScreen(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
