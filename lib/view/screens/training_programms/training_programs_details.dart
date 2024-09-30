import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_widgets/custom_widgets.dart';

class TrainingProgramsDetails extends StatelessWidget {
  TrainingProgramsDetails({super.key});

  final CustomWidgets customWidget = CustomWidgets();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackyDarkHover,
      appBar: AppBar(
        backgroundColor: AppColors.blackyDarker,
        title: const CustomText(
          text: AppStaticStrings.trainingPrograms,
          fontSize: 20,
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: homeController.trainingDetails.length,
          itemBuilder: (context, index) {
            var data = homeController.trainingDetails[index];
            return customWidget.customTrainingDetailsCard(
              image: "${ApiUrl.baseUrl}/${data.thumbnail ?? ""}",
              text: data.articleTitle ?? "",
              onTap: () {
                // Temporary debug statement
                //print("Card tapped: ${data.articleTitle}");
                Get.toNamed(AppRoute.videoShowScreen, arguments: data);
              },
            );
          },
        );
      }),
    );
  }
}
