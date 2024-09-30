import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/helper/time_converter/time_converter.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/widgets/custom_community_post/custom_community_post.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';
import 'package:k9academy/view/widgets/nav_bar/nav_bar.dart';
import 'inner/home_appbar.dart';
import 'inner/side_drawer.dart';
import '../training_programms/training_programs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();
  final GeneralController generalController = Get.find<GeneralController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      ///===================================Side Drawer=============================
      drawer: SideDrawer(),
      bottomNavigationBar: const NavBar(currentIndex: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///====================== Home AppBar and banner =======================
            HomeAppBar(scaffoldKey: scaffoldKey),
            SizedBox(
              height: 10.w,
            ),

            ///============================Training programs======================
            TrainingPrograms(),

            ///============================Community Post======================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                textAlign: TextAlign.start,
                text: AppStaticStrings.communityPost,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                bottom: 10,
                top: 10,
              ),
            ),
            Obx(() {
              return Column(
                children:
                    List.generate(homeController.communityPost.length, (index) {
                  var data = homeController.communityPost[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: GestureDetector(
                      onTap: () {
                        if (generalController.hasSubsCription.value &&
                            generalController.communityGroup.value) {
                          Get.toNamed(AppRoute.communityPostDetails,
                              arguments: data.id ?? "");
                        } else {
                          generalController.subscriptionPopUp();
                        }
                      },

                      ///============================= CustomCommunity PostDesign ===========================

                      child: CustomCommunityPost(
                        userId: data.user?.id ?? "",
                        profileImage: (data.user?.profileImage
                                    ?.startsWith('https') ??
                                false)
                            ? data.user?.profileImage ?? ""
                            : "${ApiUrl.baseUrl}${data.user?.profileImage ?? ""}",
                        coverImage: "${ApiUrl.baseUrl}${data.image ?? ""}",
                        text: data.user?.name ?? "",
                        dateTime: DateConverter.estimatedDate(
                            data.createdAt ?? DateTime.now()),
                      ),
                    ),
                  );
                }),
              );
            })
          ],
        ),
      ),
    );
  }
}
