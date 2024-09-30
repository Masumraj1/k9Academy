import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/helper/network_img/network_img.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';

class CustomCommunityPost extends StatelessWidget {
  CustomCommunityPost({
    super.key,
    required this.coverImage,
    required this.text,
    required this.dateTime,
    this.comment = true,
    this.popUpIcon,
    this.onTap,
    required this.profileImage,
    required this.userId,
  });

  final String coverImage;
  final String profileImage;
  final String text;
  final String userId;

  final String dateTime;
  final bool comment;
  final Widget? popUpIcon;
  final VoidCallback? onTap;

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // var data = homeController.communityPost[index];
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.blackyNormalActive,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Image
              GestureDetector(
                onTap: onTap,
                child: CustomNetworkImage(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  imageUrl: coverImage,
                  height: 192.h,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.otherProfile, arguments: userId);
                        },
                        child: Row(
                          children: [
                            //========================== User Image ========================

                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.otherProfile,
                                      arguments: userId);
                                },
                                child: CustomNetworkImage(
                                  imageUrl: profileImage,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //============================ User Name ===========================
                                  CustomText(
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                    text: text,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  //================================= Date ===================================
                                  CustomText(
                                    text: dateTime,
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (comment)
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.lightDarkActive,
                        ),
                        child: Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.comment,
                              imageType: ImageType.svg,
                              size: 20.sp,
                            ),
                            CustomText(
                              text: AppStaticStrings.comments,
                              left: 10,
                              fontSize: 14.sp,
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        if (popUpIcon != null)
          Positioned(
            right: 0,
            top: 0,
            child: popUpIcon!,
          ),
      ],
    );
  }
}
