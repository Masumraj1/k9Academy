import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/view/widgets/custom_community_post_details/custom_community_post_details.dart';

class CommunityPostDetails extends StatelessWidget {
  CommunityPostDetails({super.key});

  final String data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackyDarkHover,
        body: CustomCommunityPostDetails(
          id: data,
        ));
  }
}
