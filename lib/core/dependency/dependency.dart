import 'package:get/get.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/view/screens/authentication/authentication_controller/authentication_controller.dart';
import 'package:k9academy/view/screens/faq_screen/controller/faq_controller.dart';
import 'package:k9academy/view/screens/home_screen/home_controller/home_controller.dart';
import 'package:k9academy/view/screens/message_screen/controller/message_controller.dart';
import 'package:k9academy/view/screens/my_package/controller/my_package.dart';
import 'package:k9academy/view/screens/my_profile_screen/profile_controller/profile_controller.dart';
import 'package:k9academy/view/screens/notification_screen/controller/notification_controller.dart';
import 'package:k9academy/view/screens/other_profile/controller/other_profile_controller.dart';
import 'package:k9academy/view/screens/post_screen/post_controller/post_controller.dart';
import 'package:k9academy/view/screens/schedule_screen/schedule_controller/schedule_controller.dart';
import 'package:k9academy/view/screens/subscription/subscription_controller/subscription_controller.dart';

class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => SubscriptionController(), fenix: true);
    Get.lazyPut(() => ScheduleController(), fenix: true);
    Get.lazyPut(() => PostController(), fenix: true);
    Get.lazyPut(() => AuthenticationController(), fenix: true);

    Get.put(
      GeneralController(),
    );

    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => FaqController(), fenix: true);
    Get.lazyPut(() => OtherProfileController(), fenix: true);
    Get.lazyPut(() => MyPackageController(), fenix: true);

  }
}
