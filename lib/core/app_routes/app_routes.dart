import 'package:get/get.dart';
import 'package:k9academy/view/screens/about_us/about_us.dart';
import 'package:k9academy/view/screens/authentication/forget_otp_verify/forget_otp_verify.dart';
import 'package:k9academy/view/screens/authentication/forgot_pass/forgot_pass.dart';
import 'package:k9academy/view/screens/authentication/otp_verify/otp_verify.dart';
import 'package:k9academy/view/screens/authentication/reset_pass/reset_pass.dart';
import 'package:k9academy/view/screens/authentication/sign_in/sign_in.dart';
import 'package:k9academy/view/screens/authentication/sign_up/sign_up.dart';
import 'package:k9academy/view/screens/faq_screen/faq_screen.dart';
import 'package:k9academy/view/screens/home_screen/home_screen.dart';
import 'package:k9academy/view/screens/community_post/community_post_details.dart';
import 'package:k9academy/view/screens/home_screen/inner/search_screen.dart';
import 'package:k9academy/view/screens/training_programms/training_programs_details.dart';
import 'package:k9academy/view/screens/training_programms/video_show_screen.dart';
import 'package:k9academy/view/screens/my_profile_screen/inner/tab_bar_post_screen.dart';
import 'package:k9academy/view/screens/net_connection_screen/net_connection_screen.dart';
import 'package:k9academy/view/screens/notification_screen/notification_screen.dart';
import 'package:k9academy/view/screens/onboarding/onboarding.dart';
import 'package:k9academy/view/screens/other_profile/other_profile.dart';
import 'package:k9academy/view/screens/post_screen/post_screen.dart';
import 'package:k9academy/view/screens/privacy_policy/privacy_policy.dart';
import 'package:k9academy/view/screens/settings_screen/change_password_screen/change_password_screen.dart';
import 'package:k9academy/view/screens/settings_screen/settings_screen.dart';
import 'package:k9academy/view/screens/splash_screen/splash_screen.dart';
import 'package:k9academy/view/screens/subscription/subscription.dart';
import 'package:k9academy/view/screens/terms_conditon/terms_condition.dart';

import '../../view/screens/my_profile_screen/my_profile_screen.dart';

class AppRoute {
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";
  static const String onBoarding = "/onBoarding";

  ///==================== Authentication ====================
  static const String signIn = "/signIn";
  static const String forgotPass = "/forgotPass";
  static const String otpVerify = "/otpVerify";
  static const String resetPass = "/resetPass";
  static const String signUp = "/signUp";

  ///==================== Subscription ====================
  static const String subscription = "/subscription";

  ///======================HomeScreen=====================
  static const String homeScreen = "/homeScreen";

  ///=========================Profile section=================
  static const String myProfileScreen = "/myProfileScreen";

  ///==================== settingsScreen ====================
  static const String settingsScreen = "/settingsScreen";

  ///==================== aboutUs ====================
  static const String aboutUs = "/aboutUs";

  ///==================== fAQScreen ====================
  static const String fAQScreen = "/fAQScreen";

  ///==================== privacyPolicy ====================
  static const String privacyPolicy = "/privacyPolicy";

  ///==================== termsCondition ====================
  static const String termsCondition = "/termsCondition";

  ///==================== changePasswordScreen ====================
  static const String changePasswordScreen = "/ChangePasswordScreen";

  ///==================== notificationScreen ====================
  static const String notificationScreen = "/notificationScreen";

  ///==================== trainingProgramsDetails ====================
  static const String trainingProgramsDetails = "/trainingProgramsDetails";

  ///==================== communityPostDetails ====================
  static const String communityPostDetails = "/communityPostDetails";

  ///==================== videoShowScreen ====================
  static const String videoShowScreen = "/videoShowScreen";

  ///==================== videoShowScreen ====================
  static const String searchScreen = "/searchScreen";
  static const String otherProfile = "/otherProfile";
  static const String noInternetScreen = "/noInternetScreen";
  static const String tabBarPostScreen = "/tabBarPostScreen";
  static const String postScreen = "/PostScreen";
  static const String forgetOtpVerify = "/ForgetOtpVerify";

//
//
//
//
//

  static List<GetPage> routes = [
    ///==================== Initial Routes ====================

    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onBoarding, page: () => const OnBoardingPage()),

    ///==================== Authentication ====================
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPass, page: () => ForgotPassWord()),
    GetPage(name: otpVerify, page: () => const OtpVerify()),
    GetPage(name: resetPass, page: () => ResetPass()),
    GetPage(name: signUp, page: () => SignUpScreen()),

    ///==================== Subscription ====================
    GetPage(name: subscription, page: () => Subscription()),

    ///==================== HomeScreen ====================
    GetPage(name: homeScreen, page: () => HomeScreen()),

    ///==================== Profile ====================
    GetPage(name: myProfileScreen, page: () => MyProfileScreen()),

    ///==================== settingsScreen ====================
    GetPage(name: settingsScreen, page: () => SettingsScreen()),

    ///==================== aboutUs ====================
    GetPage(name: aboutUs, page: () => AboutUs()),

    ///==================== fAQScreen ====================
    GetPage(name: fAQScreen, page: () => FAQScreen()),

    ///==================== privacyPolicy ====================
    GetPage(name: privacyPolicy, page: () => PrivacyPolicy()),

    ///==================== termsCondition ====================
    GetPage(name: termsCondition, page: () => TermsCondition()),

    ///==================== changePasswordScreen ====================
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),

    ///==================== notificationScreen ====================
    GetPage(name: notificationScreen, page: () => NotificationScreen()),

    ///==================== trainingProgramsDetails ====================
    GetPage(
        name: trainingProgramsDetails, page: () => TrainingProgramsDetails()),

    ///==================== communityPostDetails ====================
    GetPage(name: communityPostDetails, page: () => CommunityPostDetails()),

    ///==================== videoShowScreen ====================
    GetPage(name: videoShowScreen, page: () => const VideoShowScreen()),

    ///==================== videoShowScreen ====================
    GetPage(name: searchScreen, page: () => SearchScreen()),
    GetPage(name: otherProfile, page: () => const OtherProfile()),
    GetPage(name: tabBarPostScreen, page: () => TabBarPostScreen()),
    GetPage(name: postScreen, page: () => const PostScreen()),
    GetPage(name: forgetOtpVerify, page: () => const ForgetOtpVerify()),
    GetPage(
        name: noInternetScreen,
        page: () => NoInternetScreen(
              onTap: () {},
            )),
  ];
}
