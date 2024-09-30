import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k9academy/helper/shared_prefe/shared_prefe.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/utils/toast_message/toast_message.dart';
import 'package:http/http.dart' as http;
import 'package:k9academy/view/screens/my_profile_screen/profile_model/profile_model.dart';
import 'package:mime/mime.dart';

class ProfileController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  var isAddItem = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  Rx<TextEditingController> dateController = TextEditingController().obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  ///==============================Select Calender Show Method=============================
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> newSelectedDate = DateTime.now().obs;
  DateTime lastDate = DateTime.now();

  Future<void> calenderShow(BuildContext context, Rx<DateTime> value) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: lastDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2201));
    if (picked != null) {
      lastDate = picked;
      value.value = lastDate;

      debugPrint("Selected Date===============>>>>>>>>>>>>>>$value");
      value.refresh();
    }
  }

  ///===============================GetProfile Method=========================

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  Rx<DataModel> profileModel = DataModel().obs;

  getProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);
    if (response.statusCode == 200) {
      profileModel.value = DataModel.fromJson(response.body["data"]);

      profileModel.refresh();
      getDataFromProfile();
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

  ///=================================profile Image Picker==================================
  RxString image = "".obs;

  Rx<File> imageFile = File("").obs;

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      image.value = getImages.path;
      multipartRequest();
    }
  }

  ///=================================Cover Image Picker==================================

  RxString coverImage = "".obs;

  Rx<File> coverImageFile = File("").obs;

  selectCoverImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      coverImageFile.value = File(getImages.path);
      coverImage.value = getImages.path;
      multipartRequest();
    }
  }

  ///======================================Edit Profile===============================
  RxBool isUpdateProfileLoading = false.obs;

  Future<void> multipartRequest({Map<String, String>? header}) async {
    isUpdateProfileLoading.value = true;
    update();
    try {
      var request = http.MultipartRequest(
          'PATCH', Uri.parse("${ApiUrl.baseUrl}${ApiUrl.editProfile}"));
      request.fields["name"] = nameController.text;
      request.fields["phone_number"] = contactController.text;
      request.fields["date_of_birth"] = newSelectedDate.value.toString();
      request.fields["age"] = ageController.text;
      request.fields["gender"] = genderController.text;
      if (image.value.isNotEmpty) {
        var mimeType = lookupMimeType(image.value);
        var img = await http.MultipartFile.fromPath(
            'profile_image', image.value,
            contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }
      if (coverImage.value.isNotEmpty) {
        var mimeType = lookupMimeType(coverImage.value);
        var img = await http.MultipartFile.fromPath(
            'cover_image', coverImage.value,
            contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }
      var token = await SharePrefsHelper.getString(AppConstants.bearerToken);
      request.headers['Authorization'] = "Bearer $token";

      var response = await request.send();
      isUpdateProfileLoading.value = false;
      update();
      debugPrint(
          "=====${response.statusCode}===============================Success");
      if (response.statusCode == 200) {
        getProfile();
        var data = await response.stream.bytesToString();
        isAddItem.value = !isAddItem.value;
        toastMessage(
            message: "Profile Update successfully", color: Colors.green);
        debugPrint("=================> data $data");
        isUpdateProfileLoading.value = false;
        update();
      } else {
        var data = await response.stream.bytesToString();

        debugPrint("=================> data $data");
      }
    } catch (e) {
      debugPrint("============> $e");
    }
  }

  getDataFromProfile() {
    var value = profileModel.value.userInfo;
    nameController = TextEditingController(text: value?.name ?? "");
    emailController = TextEditingController(text: value?.email ?? "");
    contactController = TextEditingController(text: value?.phoneNumber ?? "");
    // dateController = TextEditingController(
    //     text: DateConverter.formatDetails("${value?.date_of_birth}"));
    ageController = TextEditingController(text: value?.age ?? "");
    genderController = TextEditingController(text: value?.gender ?? "");
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
