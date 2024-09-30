import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/network_img/network_img.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/post_screen/post_controller/post_controller.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:k9academy/view/widgets/nav_bar/nav_bar.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostController postController = Get.find<PostController>();

  final String id = Get.arguments[0];

  final bool isUpdate = Get.arguments[1];

  final Map<String, String> data = Get.arguments[2];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isUpdate) {
        postController.descriptionController.value =
            TextEditingController(text: data["des"]);
      } else {
        postController.descriptionController.value.clear();
      }
      postController.descriptionController.refresh();

      postController.clearImage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 2),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                isUpdate
                    ? postController.editPost(id: id)
                    : postController.multipartRequest();
              },
              icon: Container(
                decoration: BoxDecoration(
                    color: AppColors.blueNormal,
                    borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: CustomText(
                  text: isUpdate
                      ? AppStaticStrings.update
                      : AppStaticStrings.post,
                  fontWeight: FontWeight.w500,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Obx(() {
          return Column(
            children: [
              CustomTextField(
                maxLength: 1000,
                maxLines: 10,
                textEditingController:
                    postController.descriptionController.value,
                hintText: "Please provide a brief..............",
                hintStyle: const TextStyle(color: AppColors.lightDarker),
              ),

              const SizedBox(
                height: 20,
              ),

              ///=========================== Image Picker =============================

              GestureDetector(
                  onTap: () {
                    postController.selectImage();
                  },
                  child: postController.image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            File(postController.image.value),
                            fit: BoxFit.cover,
                          ),
                        )
                      : isUpdate
                          ? CustomNetworkImage(
                              imageUrl: data["image"] ?? "",
                              height: 300,
                              width: 400)
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: AppColors.lightDark)),
                              child: const SizedBox(
                                  height: 300,
                                  width: 400,
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 200,
                                  )),
                            ))
            ],
          );
        }),
      ),
    );
  }
}
