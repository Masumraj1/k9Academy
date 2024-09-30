import 'package:get/get.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/view/screens/notification_screen/model/notification_model.dart';

class NotificationController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///============================ Get Notification ===============================

  RxList<NotificationDatum> notifications = <NotificationDatum>[].obs;

  getNotifications() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.notifications);

    if (response.statusCode == 200) {
      notifications.value = List<NotificationDatum>.from(response.body["data"]
              ["data"]
          .map((x) => NotificationDatum.fromJson(x)));

      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///====================== Read All Notifications =========================
  readAllNotification() async {
    var response =
        await ApiClient.patchData(ApiUrl.notificationRead, {}, isBody: false);
    if (response.statusCode == 200) {
      getNotifications();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }
}
