import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/view/screens/message_screen/controller/message_controller.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';

class ChatBubbleMessage extends StatefulWidget {
  const ChatBubbleMessage({
    super.key,
  });

  @override
  State<ChatBubbleMessage> createState() => _ChatBubbleMessageState();
}

class _ChatBubbleMessageState extends State<ChatBubbleMessage> {
  final MessageController messageController = Get.find<MessageController>();
  @override
  void dispose() {
    super.dispose();
  }

//
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          switch (messageController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  messageController.getMessageList();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  messageController.getMessageList();
                },
              );

            case Status.completed:
              return ListView.builder(
                  // reverse: true,
                  controller: messageController.scrollController.value,
                  itemCount: messageController.messageList.length,
                  itemBuilder: (context, index) {
                    var data = messageController.messageList[index];
                    if (messageController.isLoadMoreRunning.value == false) {
                      return Column(
                        ///=======================Align the text based on user=================
                        crossAxisAlignment: data.sender == "user"
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: data.sender == "user"
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                if (data.messageType == "text" ||
                                    data.messageType == "both")
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: data.sender == "user"
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        ///=======================Show time if Getting Message=================

                                        if (data.sender == "user")
                                          CustomText(
                                            right: 10.w,
                                            text: DateConverter.hourMinit(
                                                data.createdAt ??
                                                    DateTime.now()),
                                            color: AppColors.redLight,
                                            fontSize: 10.w,
                                            fontWeight: FontWeight.w200,
                                          ),

                                        ///============================Message Body==============================

                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: data.sender == "user"
                                                        ? AppColors
                                                            .lightDarkHover
                                                        : AppColors.blueNormal,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: data.messageType ==
                                                        "both"
                                                    ? null
                                                    : data.sender == "user"
                                                        ? AppColors.messageText
                                                        : AppColors
                                                            .blueNormalHover),
                                            child: Column(
                                              children: [
                                                if (data.messageType == "both")
                                                  Container(
                                                      height: 160.h,
                                                      width: 260.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: CachedNetworkImageProvider(
                                                                "${ApiUrl.baseUrl}${data.image ?? ""}",
                                                              )))),
                                                CustomText(
                                                  maxLines: 100,
                                                  textAlign: TextAlign.left,
                                                  fontSize: 12,
                                                  top:
                                                      data.messageType == "both"
                                                          ? 10
                                                          : 0,
                                                  fontWeight: FontWeight.w400,
                                                  text: data.message ?? "",
                                                  color: data.sender == "user"
                                                      ? AppColors.light
                                                      : AppColors.light,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        ///=======================Show time if Sending Message=================

                                        if (data.sender != "user")
                                          CustomText(
                                            left: 10.w,
                                            text: DateConverter.hourMinit(
                                                data.createdAt ??
                                                    DateTime.now()),
                                            fontSize: 10.w,
                                            fontWeight: FontWeight.w200,
                                          ),
                                      ],
                                    ),
                                  ),
                                if (data.messageType == "image")
                                  Container(
                                      height: 160.h,
                                      width: 260.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                "${ApiUrl.baseUrl}${data.image ?? ""}",
                                              )))),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });
          }
        }));
  }
}
