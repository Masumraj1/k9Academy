import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/screens/notification_screen/controller/notification_controller.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackyDarkHover,
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: AppStaticStrings.notifications,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  controller.getNotifications();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getNotifications();
                },
              );

            case Status.completed:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ///========================== Read All Notification ================================
                  if (controller.notifications.isNotEmpty)
                    TextButton(
                        onPressed: () {
                          controller.readAllNotification();
                        },
                        child: const CustomText(
                          text: AppStaticStrings.readAll,
                          fontSize: 18,
                          color: AppColors.blueNormal,
                        )),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) {
                        var data = controller.notifications[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.1, 1.0), //(x,y)
                                blurRadius: 1,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(14),
                            color: data.status == true
                                ? AppColors.lightDarkActive
                                : AppColors.blueNormal,
                          ),
                          padding: EdgeInsets.all(20.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///======================== Title ========================

                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                text: data.title ?? "",
                                color: AppColors.lightNormal,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),

                              ///======================= Sub Title ======================

                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                top: 6,
                                bottom: 6,
                                text: data.message ?? "",
                                fontWeight: FontWeight.w500,
                              ),

                              ///======================= Time ======================

                              CustomText(
                                text: DateConverter.estimatedDate(
                                    data.createdAt ?? DateTime.now()),
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
          }
        }));
  }
}
