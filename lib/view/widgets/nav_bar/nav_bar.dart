import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_icons/app_icons.dart';
import 'package:k9academy/view/screens/home_screen/home_screen.dart';
import 'package:k9academy/view/screens/message_screen/message_screen.dart';
import 'package:k9academy/view/screens/my_profile_screen/my_profile_screen.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var bottomNavIndex = 0;

  List<String> unselectedIcon = [
    AppIcons.homeUnselected,
    AppIcons.chartUnselected,
    AppIcons.postUnselected,
    AppIcons.profileUnselected,
  ];

  List<String> selectedIcon = [
    AppIcons.homeSelected,
    AppIcons.chartSelected,
    AppIcons.postSelected,
    AppIcons.profileSelected,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackyDarkHover,
      height: 66.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 30.w, vertical: 7.h),
      alignment: Alignment.center,
      // color: AppColors.greenNormalGreen4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(2),
              child: Container(
                decoration: BoxDecoration(
                    color: index == bottomNavIndex ? AppColors.redNormal : null,
                    borderRadius: BorderRadius.circular(30)),
                child: index == bottomNavIndex
                    ? SvgPicture.asset(
                        selectedIcon[index],
                        height: 48.w,
                        width: 48.h,
                      )
                    : SvgPicture.asset(
                        unselectedIcon[index],
                        height: 48.w,
                        width: 48.h,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.to(() => HomeScreen());
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.to(() => MessageScreen());
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Map<String, String> data = {};
        Get.toNamed(AppRoute.postScreen, arguments: ["", false, data]);
      }
    }
    //
    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.to(() => MyProfileScreen());
      }
    }
  }
}
