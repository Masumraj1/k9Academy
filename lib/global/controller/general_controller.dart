import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k9academy/core/app_routes/app_routes.dart';
import 'package:k9academy/helper/shared_prefe/shared_prefe.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_colors/app_colors.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/static_strings/static_strings.dart';
import 'package:k9academy/view/screens/my_package/controller/my_package.dart';
import 'package:k9academy/view/widgets/custom_button/custom_button.dart';
import 'package:k9academy/view/widgets/custom_loader/custom_loader.dart';
import 'package:k9academy/view/widgets/custom_text/custom_text.dart';

class GeneralController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///========================== Show Popup Loader ========================
  showPopUpLoader() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) {
          return const SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: CustomLoader(),
            ),
          );
        });
  }

  ///========================== Get User ID ========================
  RxString userId = "".obs;

  getId() async {
    String id = await SharePrefsHelper.getString(AppConstants.profileID);

    userId.value = id;

    debugPrint("User Id Controller ======================>>>>>>>>>>>>$id");
    refresh();
  }

  ///========================== Pick Image ========================
  Rx<File> imageFile = File("").obs;
  RxString imagePath = "".obs;

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      imagePath.value = getImages.path;
    }
  }

  ///============================== Get Content (About us, Privacy Policy, Terms) ============================

  RxString about = "".obs;
  RxString privacy = "".obs;
  RxString terms = "".obs;

  getContent() async {
    setRxRequestStatus(Status.loading);
    var aboutRes = await ApiClient.getData(ApiUrl.aboutUs);
    var privacyRes = await ApiClient.getData(ApiUrl.privacy);
    var termsRes = await ApiClient.getData(ApiUrl.terms);

    if (aboutRes.statusCode == 200 &&
        privacyRes.statusCode == 200 &&
        termsRes.statusCode == 200) {
      about.value = aboutRes.body["data"]["description"];
      privacy.value = aboutRes.body["data"]["description"];
      terms.value = aboutRes.body["data"]["description"];
      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (aboutRes.statusText == ApiClient.noInternetMessage ||
          privacyRes.statusText == ApiClient.noInternetMessage ||
          termsRes.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(aboutRes);
      ApiChecker.checkApi(privacyRes);
      ApiChecker.checkApi(termsRes);
    }
  }

  String token = "";

  ///=============================== Get Conversation ID ==============================
  RxString conversationID = "".obs;
  getConversationID() async {
    conversationID.value =
        await SharePrefsHelper.getString(AppConstants.conversationID);

    refresh();

    debugPrint(
        "Conversation Id: ============<><><><><><>>>>${conversationID.value}");
  }

  ///=============================== Get If Has Subscription ==============================
  RxBool hasSubsCription = false.obs;
  Future<void> getSubsInfo() async {
    hasSubsCription.value =
        await SharePrefsHelper.getBool(AppConstants.hasSubsCription) ?? false;

    refresh();

    debugPrint(
        "hasSubsCription: ============<><><><><><>>>>${hasSubsCription.value}");
    getSubscriptionLogic();
  }

  ///=============================== Save Conversation ID ==============================
  saveConversationID() async {
    var response = await ApiClient.postData(ApiUrl.createConversation, {},
        contentType: false);
    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          AppConstants.conversationID, response.body["data"]["_id"]);

      getConversationID();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///============================== Get Subscriptions Logic ==============================
  RxBool trainingVideo = false.obs;
  RxBool communityGroup = false.obs;
  RxBool chat = false.obs;
  RxBool virtualLesson = false.obs;
  RxBool program = false.obs;

  getSubscriptionLogic() async {
    MyPackageController myPackageController = Get.find<MyPackageController>();

    bool done = await myPackageController.getMyPackage();
    if (done) {
      trainingVideo.value =
          await SharePrefsHelper.getBool(AppConstants.videoTraining) ?? false;

      communityGroup.value =
          await SharePrefsHelper.getBool(AppConstants.communityGroup) ?? false;

      chat.value = await SharePrefsHelper.getBool(AppConstants.chat) ?? false;

      virtualLesson.value =
          await SharePrefsHelper.getBool(AppConstants.virtualLesson) ?? false;

      program.value =
          await SharePrefsHelper.getBool(AppConstants.program) ?? false;

      debugPrint(
          "Subscription Logic ===============>>>>>>>>> trainingVideo:$trainingVideo communityGroup:$communityGroup chat:$chat virtualLesson:$virtualLesson program:$program");

      refresh();
    }
  }

  ///======================= Dont have necessary Subscription Permission ==========================

  subscriptionPopUp() {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      backgroundColor: AppColors.blackyDarker,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomText(
              maxLines: 2,
              text: AppStaticStrings.youDontHaveNecessary,
              fontSize: 14.w,
              bottom: 10.h,
            ),
            CustomButton(
              onTap: () {
                navigator?.pop();
                Get.toNamed(AppRoute.subscription);
              },
              title: AppStaticStrings.subscriptionNow,
            ),
          ],
        ),
      ),
    ));
  }

  ///========================== Hit all methods based on token ==============================

  hitAllAPI() async {
    token = await SharePrefsHelper.getString(AppConstants.bearerToken);

    if (token.isNotEmpty) {
      getContent();
      getId();
      saveConversationID();
      getConversationID();
      getSubsInfo();
    }
  }

  @override
  void onInit() {
    hitAllAPI();
    super.onInit();
  }
}
