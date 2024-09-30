import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';

class MessageInputField extends StatelessWidget {
  MessageInputField(
      {super.key,
      required this.writeMsgController,
      required this.onTap,
      this.isComment = false});

  final TextEditingController writeMsgController;

  final VoidCallback onTap;
  final bool isComment;

  final GeneralController generalController = Get.find<GeneralController>();

  Widget design(BuildContext context) => AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: isComment ? 20 : 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///============================== Image Pick Design ============================
              if (!isComment && generalController.imagePath.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 120,
                  width: 220,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightDarkHover),
                    borderRadius: BorderRadius.circular(8.r),
                    // image: DecorationImage(
                    //     //fit: BoxFit.cover,
                    //     image: FileImage(
                    //         File(generalController.imagePath.value)))
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 100,
                          width: 150,
                          child: Image.file(
                              File(generalController.imagePath.value))),
                      IconButton(
                          onPressed: () {
                            generalController.imagePath.value = "";
                            generalController.imagePath.refresh();
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.light)),
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.lightNormalActive,
                            ),
                          )),
                    ],
                  ),
                ),
              Row(
                children: [
                  //=============================== Gallery Button ==========================

                  if (!isComment)
                    IconButton(
                      onPressed: () {
                        generalController.selectImage();
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                        size: 36,
                      ),
                    ),
                  //============================Text Input Field=====================

                  Expanded(
                      child: CustomTextField(
                    textEditingController: writeMsgController,
                    textInputAction: TextInputAction.done,
                    hintText: "write your message",
                    fieldBorderColor: AppColors.blueNormal,
                    focusBorderColor: AppColors.blueNormal,
                    fillColor: Colors.transparent,
                    borderRadius: 10.r,
                  )),

                  //=============================== Send Button ==========================

                  GestureDetector(
                    onTap: () {
                      onTap();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 4.w),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColors.redNormal),
                      child: const Icon(
                        Icons.send_sharp,
                        color: AppColors.lightNormal,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (isComment) {
      return design(context);
    } else {
      return Obx(() {
        return design(context);
      });
    }
  }
}
