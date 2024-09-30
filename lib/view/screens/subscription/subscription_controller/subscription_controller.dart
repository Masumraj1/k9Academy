import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/helper/shared_prefe/shared_prefe.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/toast_message/toast_message.dart';
import 'package:k9academy/view/screens/my_package/controller/my_package.dart';
import 'package:k9academy/view/screens/subscription/model/subscription_model.dart';

class SubscriptionController extends GetxController {
  RxBool isPromoCode = false.obs;
  GeneralController generalController = Get.find<GeneralController>();
  MyPackageController myPackageController = Get.find<MyPackageController>();

  ///==================================GetSubscription===========================
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList<SubscriptionData> subscriptionLists = <SubscriptionData>[].obs;
  getSubscription() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.subscriptionPlanAll);

    if (response.statusCode == 200) {
      subscriptionLists.value = List<SubscriptionData>.from(
          response.body["data"].map((x) => SubscriptionData.fromJson(x)));
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

  ///=====================================PromoPackageGet==============================
  Rx<SubscriptionData> promoData = SubscriptionData().obs;
  getPromoPackage() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getPromoPackage);

    if (response.statusCode == 200) {
      promoData.value = SubscriptionData.fromJson(response.body["data"]);
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

  ///==================================== Promo Code  Post =========================
  RxBool isPromoLoading = false.obs;
  TextEditingController promoController = TextEditingController();
  promoCodeApply() async {
    isPromoLoading.value = true;
    refresh();
    Map<String, String> body = {"promo_code": promoController.text};

    var response = await ApiClient.postData(ApiUrl.promoCode, jsonEncode(body));
    if (response.statusCode == 200) {
      SharePrefsHelper.setBool(AppConstants.hasSubsCription, true);
      generalController.getSubsInfo().then((value) {
        generalController.getSubscriptionLogic();
      });
      toastMessage(message: response.body["message"], color: Colors.green);
      isPromoCode.value = !isPromoCode.value;
      isPromoCode.refresh();
      navigator!.pop();
      promoController.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    isPromoLoading.value = false;
  }

  ///========================= Create Payment Intent =========================

  Future<Map<String, dynamic>?> createPaymentIntent({
    required String amount,
  }) async {
    generalController.showPopUpLoader();

    Map<String, dynamic> body = {"price": amount};
    var response = await ApiClient.postData(
        contentType: false, ApiUrl.createPaymentIntent, body);

    if (response.statusCode == 200) {
      return response.body["data"];
    } else {
      ApiChecker.checkApi(response);
      navigator!.pop();
      return null;
    }
  }

  ///========================= Make Payment =========================

  Future<bool> makePayment(
      {required String amount, required String packageID}) async {
    Map<String, dynamic>? paymentIntentData;
    try {
      paymentIntentData = await createPaymentIntent(
        amount: amount,
      );
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Rafsan Hossain',
          paymentIntentClientSecret: paymentIntentData["client_secret"],
          allowsDelayedPaymentMethods: true,
        ));
        await Stripe.instance.presentPaymentSheet();
        bool instant = await makeOrder(
            amount: amount,
            packageID: packageID,
            transactionId: paymentIntentData["transactionId"]);

        return instant;
      } else {
        navigator!.pop();
        return false;
      }
    } catch (e) {
      navigator!.pop();

      debugPrint("Error2 ================>>>>>>>>>>>>>${e.toString()}");
      toastMessage(message: "Something went wrong");
      return false;
    }
  }

  ///========================= Make Order =========================

  Future<bool> makeOrder(
      {required String amount,
      required String packageID,
      required String transactionId}) async {
    Map<String, dynamic> body = {
      "plan_id": packageID,
      "transaction_id": transactionId,
      "amount": amount
    };

    var response =
        await ApiClient.postData(ApiUrl.makeOrder, body, contentType: false);

    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"], color: Colors.green);
      SharePrefsHelper.setBool(AppConstants.hasSubsCription, true);
      generalController.getSubsInfo().then((value) {
        generalController.getSubscriptionLogic();
      });

      navigator!.pop();
      return true;
    } else {
      ApiChecker.checkApi(response);
      navigator!.pop();
      return false;
    }
  }

  @override
  void onInit() {
    getSubscription();
    getPromoPackage();
    super.onInit();
  }
}
