import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/view/screens/schedule_screen/model/schedule_model.dart';

class ScheduleController extends GetxController {
  var dates = <DateTime>[].obs;
  TextEditingController meetingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void updateDates(List<DateTime> newDates) {
    dates.value = newDates;
  }

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///========================================Get Schedule====================================
  RxList<ScheduleData> scheduleList = <ScheduleData>[].obs;

  getSchedule() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.schedule);
    if (response.statusCode == 200) {
      scheduleList.value = List<ScheduleData>.from(
          response.body["data"].map((x) => ScheduleData.fromJson(x)));
      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);

      refresh();
    }
  }

  @override
  void onInit() {
    getSchedule();
    super.onInit();
  }
}
