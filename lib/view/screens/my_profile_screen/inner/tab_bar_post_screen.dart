import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/screens/post_screen/post_controller/post_controller.dart';
import 'package:k9academy/view/widgets/custom_community_post/custom_community_post.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/error/genarel_error.dart';

class TabBarPostScreen extends StatelessWidget {
  TabBarPostScreen({super.key, this.postId});

  final HomeController homeController = Get.find<HomeController>();
  final PostController postController = Get.find<PostController>();
  final String? postId;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (postController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              postController.getMyPost();
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              postController.getMyPost();
            },
          );

        case Status.completed:
          return SingleChildScrollView(
            child: postController.postData.isEmpty
                ? Center(
                    child: CustomText(
                    top: 80.h,
                    text: AppStaticStrings.noPostYet,
                    fontSize: 20,
                  ))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        children: List.generate(postController.postData.length,
                            (index) {
                      var data = postController.postData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: CustomCommunityPost(
                          userId: "",
                          popUpIcon: PopupMenuButton<String>(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            onSelected: (value) {},
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                onTap: () {
                                  Get.toNamed(AppRoute.postScreen, arguments: [
                                    data.id ?? "",
                                    true,
                                    {
                                      "image":
                                          "${ApiUrl.baseUrl}${data.image ?? ""}",
                                      "des": data.description ?? ""
                                    }
                                  ]);
                                },
                                child: const Text('Edit'),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {
                                  postController.deletePost(data.id ?? "");
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                          ),
                          profileImage: (data.user?.profileImage
                                      ?.startsWith('https') ??
                                  false)
                              ? data.user?.profileImage ?? ""
                              : "${ApiUrl.baseUrl}${data.user?.profileImage}",
                          comment: false,
                          onTap: () {
                            Get.toNamed(AppRoute.communityPostDetails,
                                arguments: data.id ?? "");
                          },
                          coverImage: "${ApiUrl.baseUrl}${data.image ?? ""}",
                          text: data.user?.name ?? "",
                          dateTime: DateConverter.formatTime(
                              "${data.createdAt ?? DateTime.now()}"),
                        ),
                      );
                    })),
                  ),
          );
      }
    });
  }
}
