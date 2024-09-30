import 'package:get/get.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/view/screens/faq_screen/model/faq_model.dart';

class FaqController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxInt selectedFqw = 100000.obs;

  ///========================== Get Faq =============================
  ///
  RxList<FaqDatum> faqList = <FaqDatum>[].obs;
  getFaq() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.faq);

    if (response.statusCode == 200) {
      faqList.value = List<FaqDatum>.from(
          response.body["data"].map((x) => FaqDatum.fromJson(x)));

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

  @override
  void onInit() {
    getFaq();
    super.onInit();
  }
}
