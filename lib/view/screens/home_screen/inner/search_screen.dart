import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:k9academy/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:k9academy/view/widgets/error/genarel_error.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackyDarkHover,
      appBar: AppBar(
        backgroundColor: AppColors.blackyDarker,
        centerTitle: true,
        title: CustomText(
          text: AppStaticStrings.search,
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
        ),
      ),
      body: Column(
        children: [
          ///============================Search Field=======================
          Container(
            width: double.infinity,
            color: AppColors.blackyDark,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: CustomTextField(
                onFieldSubmitted: (value) {
                  homeController.search(search: value);
                },
                fillColor: AppColors.lightDarkActive,
                hintText: AppStaticStrings.searchHere,
                hintStyle: const TextStyle(color: AppColors.lightNormalActive),
                isPrefixIcon: true,
                borderRadius: 25,
              ),
            ),
          ),

          ///============================Results List========================
          Obx(() {
            switch (homeController.rxRequestStatus.value) {
              case Status.loading:
                return const CustomLoader();
              case Status.internetError:
                return NoInternetScreen(
                  onTap: () {
                    homeController.getTrainingProgramAll();
                  },
                );
              case Status.error:
                return GeneralErrorScreen(
                  onTap: () {
                    homeController.getTrainingProgramAll();
                  },
                );
              case Status.completed:
                return Expanded(
                  child: ListView.builder(
                    itemCount: homeController.trainingProgramsList.length,
                    itemBuilder: (context, index) {
                      var data = homeController.trainingProgramsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: customWidget.customTrainingDetailsCard(
                          image: "${ApiUrl.baseUrl}${data.thumbnail}",
                          text: data.articleTitle ?? "",
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                );
              default:
                return Container(); // Return an empty container for an unknown state.
            }
          })
        ],
      ),
    );
  }
}
