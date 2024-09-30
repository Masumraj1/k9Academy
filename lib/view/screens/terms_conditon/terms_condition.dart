import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/general_error/general_error.dart';

class TermsCondition extends StatelessWidget {
  TermsCondition({super.key});
  final GeneralController controller = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackyDarkHover,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStaticStrings.termsConditions,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: () {
              controller.getContent();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getContent();
              },
            );

          case Status.completed:
            // return Center();
            return controller.terms.value.isEmpty
                ? const Center(
                    child: CustomText(
                      text: 'Empty',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    physics: const BouncingScrollPhysics(),
                    child: HtmlWidget(
                        textStyle: const TextStyle(color: AppColors.light),
                        controller.terms.value));
        }
      }),
    );
  }
}
