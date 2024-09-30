import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/utils/toast_message/toast_message.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/screens/schedule_screen/schedule_controller/schedule_controller.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_image/custom_image.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:k9academy/view/widgets/error/genarel_error.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});

  void showDialogBox(
      BuildContext context, String meetingLink, String password, String date) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.blackyDarkHover,
        content: SizedBox(
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CustomImage(
                      imageSrc: AppIcons.x,
                      imageType: ImageType.svg,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const CustomText(
                    text: "Meeting date:",
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightNormal,
                    bottom: 14,
                    right: 10,
                  ),
                  CustomText(
                    text: date,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueNormal,
                    bottom: 14,
                  ),
                ],
              ),
              CustomText(
                text: AppStaticStrings.link,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.lightNormalHover,
                bottom: 16,
              ),
              CustomTextField(
                readOnly: true,
                textEditingController: scheduleController.meetingController =
                    TextEditingController(text: meetingLink),
                maxLines: 4,
                suffixIcon: IconButton(
                    onPressed: () async {
                      await FlutterClipboard.copy(
                          scheduleController.meetingController.text);
                      toastMessage(message: "Copied to Meeting Link");
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: Colors.white,
                    )),
              ),
              CustomText(
                top: 16,
                text: AppStaticStrings.password,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.lightNormalHover,
                bottom: 16,
              ),
              CustomTextField(
                readOnly: true,
                textEditingController: scheduleController.passwordController =
                    TextEditingController(text: password),
                suffixIcon: IconButton(
                    onPressed: () async {
                      await FlutterClipboard.copy(
                          scheduleController.passwordController.text);
                      toastMessage(message: "Copied to Password");
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final ScheduleController scheduleController = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (scheduleController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              scheduleController.getSchedule();
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              scheduleController.getSchedule();
            },
          );
        case Status.completed:
          List<DateTime?> scheduleDates = scheduleController.scheduleList
              .map((schedule) => schedule.date)
              .toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                scheduleController.scheduleList.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.blackyNormalActive,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarType: CalendarDatePicker2Type.multi,
                            daySplashColor: AppColors.lightNormalActive,
                            controlsTextStyle:
                                const TextStyle(color: AppColors.light),
                            dayTextStyle:
                                const TextStyle(color: AppColors.lightDark),
                            monthTextStyle:
                                const TextStyle(color: AppColors.light),
                            yearTextStyle:
                                const TextStyle(color: AppColors.light),
                            weekdayLabelTextStyle:
                                const TextStyle(color: AppColors.light),
                            selectedDayHighlightColor: AppColors.blueNormal,
                          ),
                          value: scheduleDates,
                        ))
                    : Center(
                        child: CustomText(
                            top: 80.h,
                            fontSize: 20,
                            text: AppStaticStrings.noScheduleFound)),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: List.generate(
                    scheduleController.scheduleList.length,
                    (index) {
                      var data = scheduleController.scheduleList[index];
                      return Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.blackyNormalActive,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: DateConverter.estimatedDate(
                                      data.date ?? DateTime.now()),
                                  color: AppColors.blueNormal,
                                  bottom: 7,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                                CustomText(
                                  text: DateConverter.formatTime(
                                      "${data.createdAt ?? DateTime.now()}"),
                                  color: AppColors.lightActive,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 50.h,
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: AppStaticStrings.consultation,
                                    color: AppColors.lightNormalHover,
                                    bottom: 7,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      showDialogBox(
                                          context,
                                          data.meetLink ?? '',
                                          data.password ?? "",
                                          DateConverter.estimatedDate(
                                              data.date ?? DateTime.now()));
                                    },
                                    title: AppStaticStrings.meetingLink,
                                    fillColor: AppColors.redNormal,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
      }
    });
  }
}
