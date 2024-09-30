import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/network_img/network_img.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/screens/message_screen/inner/message_input_field.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';
import 'package:readmore/readmore.dart';

class CustomCommunityPostDetails extends StatefulWidget {
  const CustomCommunityPostDetails({
    super.key,
    this.comment = true,
    this.id,
  });

  final bool comment;
  final String? id;

  @override
  State<CustomCommunityPostDetails> createState() =>
      _CustomCommunityPostDetailsState();
}

class _CustomCommunityPostDetailsState
    extends State<CustomCommunityPostDetails> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    homeController.getSingleCommunityPost(id: widget.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (homeController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(
            onTap: () {},
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              homeController.getSingleCommunityPost(id: widget.id ?? "");
            },
          );

        case Status.completed:
          var value = homeController.singleCommunityPost.value;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 64.h,
                ),

                ////========================= Top Profile Section =========================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.light,
                      ),
                    ),

                    ///================== Image =================

                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl:
                          (value.user?.profileImage?.startsWith('https') ??
                                  false)
                              ? value.user?.profileImage ?? ""
                              : "${ApiUrl.baseUrl}${value.user?.profileImage}",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),

                    ///================== Name =================

                    CustomText(
                      fontSize: 14,
                      text: value.user?.name ?? "",
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReadMoreText(
                        style: const TextStyle(color: AppColors.light),
                        value.description ?? "",
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightNormalActive),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      ///===================================== Cover Image =====================
                      CustomNetworkImage(
                        borderRadius: BorderRadius.circular(8),
                        imageUrl: "${ApiUrl.baseUrl}${value.image ?? ""}",
                        width: double.infinity,
                        height: 220,
                      ),

                      ///=============================Comment =====================
                      if (widget.comment)
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: AppColors.lightDarkActive,
                                context: context,
                                builder: (context) {
                                  return MessageInputField(
                                    isComment: true,
                                    onTap: () {
                                      homeController.writeComments(
                                          postId: value.id ?? "");
                                    },
                                    writeMsgController:
                                        homeController.writeController.value,
                                  );
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width / 2.5,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.lightDarkActive),
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
                        ),
                      SizedBox(
                        height: 15.w,
                      ),
                      const Divider(),

                      CustomText(
                        top: 12,
                        text: AppStaticStrings.allComments,
                        color: AppColors.blueNormal,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        bottom: 5,
                      ),

                      ///============================== All Comments ==================================

                      Column(
                        children:
                            List.generate(value.comments?.length ?? 0, (index) {
                          var comments = value.comments?[index];
                          return Row(
                            children: [
                              ///================== User Image ====================

                              CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                imageUrl: (comments?.user?.profileImage
                                            ?.startsWith('https') ??
                                        false)
                                    ? comments?.user?.profileImage ?? ""
                                    : "${ApiUrl.baseUrl}${comments?.user?.profileImage ?? ""}",
                                height: 50,
                                width: 50,
                              ),

                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.blackyDark,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///================== User name ===================
                                    CustomText(
                                      text: comments?.user?.name ?? "",
                                      fontWeight: FontWeight.w600,
                                    ),

                                    ///================== Comment ===================

                                    CustomText(
                                      maxLines: 3,
                                      color: AppColors.lightNormalHover,
                                      text: comments?.content ?? "",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
      }
    });
  }
}
