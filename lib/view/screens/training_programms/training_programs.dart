import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_widgets/custom_widgets.dart';

class TrainingPrograms extends StatelessWidget {
  TrainingPrograms({
    super.key,
  });

  ///=================================CustomTrainingCard==============================
  final CustomWidgets customWidget = CustomWidgets();

  final HomeController homeController = Get.find<HomeController>();
  final GeneralController generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.homeScreenBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///=====================================Training Programs====================================
          CustomText(
            textAlign: TextAlign.start,
            text: AppStaticStrings.trainingPrograms,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            bottom: 12,
            top: 15,
          ),

          Obx(() {
            return SizedBox(
              height: 260.w,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: generalController.hasSubsCription.value
                      ? homeController.trainingList.length
                      : homeController.trainingList.length >= 3
                          ? 3
                          : homeController.trainingList.length,
                  itemBuilder: (context, index) {
                    var data = homeController.trainingList[index];
                    return GestureDetector(
                      onTap: () {
                        homeController.getTrainingDetails(id: data.id ?? "");
                        Get.toNamed(AppRoute.trainingProgramsDetails);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: customWidget.customTrainingCard(
                              image: "${ApiUrl.baseUrl}/${data.image ?? ""}",
                              text: data.title ?? "")),
                    );
                  }),
            );
          }),

          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
