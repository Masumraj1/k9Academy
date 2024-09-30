import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k9academy/global/controller/general_controller.dart';
import 'package:k9academy/services/api_check.dart';
import 'package:k9academy/services/api_client.dart';
import 'package:k9academy/services/app_url.dart';
import 'package:k9academy/utils/app_const/app_const.dart';
import 'package:k9academy/view/screens/home_screen/model/community_post_model.dart';
import 'package:k9academy/view/screens/home_screen/model/training_details.dart';
import 'package:k9academy/view/screens/home_screen/model/training_program_all_model.dart';
import 'package:k9academy/view/screens/home_screen/model/training_programs.dart';

class HomeController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  GeneralController generalController = Get.find<GeneralController>();

  ///========================== Training Programms ===========================
  RxList<TrainingDatum> trainingList = <TrainingDatum>[].obs;

  Future<bool> getTrainingProgramm() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.trainingPrograms);

    if (response.statusCode == 200) {
      trainingList.value = List<TrainingDatum>.from(
          response.body["data"].map((x) => TrainingDatum.fromJson(x)));

      return true;
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);

      return false;
    }
  }

  ///========================== Community Post ===========================

  RxList<CommunityDatum> communityPost = <CommunityDatum>[].obs;

  Rx<CommunityDatum> singleCommunityPost = CommunityDatum().obs;

  Future<bool> getCommunityPost() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.communityPost);

    if (response.statusCode == 200) {
      communityPost.value = List<CommunityDatum>.from(
          response.body["data"].map((x) => CommunityDatum.fromJson(x)));
      setRxRequestStatus(Status.completed);

      refresh();
      return true;
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);

      refresh();

      return false;
    }
  }

  ///========================== Single Community Post ===========================
  getSingleCommunityPost({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.singleCommunityPost(id: id));

    if (response.statusCode == 200) {
      singleCommunityPost.value =
          CommunityDatum.fromJson(response.body["data"]);
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

  ///========================== Training Programms Details ===========================

  RxList<TrainingDetailsDatum> trainingDetails = <TrainingDetailsDatum>[].obs;

  getTrainingDetails({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.trainingDetails(id: id));

    if (response.statusCode == 200) {
      trainingDetails.value = List<TrainingDetailsDatum>.from(
          response.body["data"].map((x) => TrainingDetailsDatum.fromJson(x)));
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

  ///========================== Write Comments ===========================

  Rx<TextEditingController> writeController = TextEditingController().obs;
  writeComments({required String postId}) async {
    navigator!.pop();

    generalController.showPopUpLoader();
    var body = {"postId": postId, "content": writeController.value.text};

    var response =
        await ApiClient.postData(ApiUrl.postComments, jsonEncode(body));

    if (response.statusCode == 200) {
      navigator!.pop();
      writeController.value.clear();

      getSingleCommunityPost(id: postId);
    } else {
      navigator!.pop();
      writeController.value.clear();

      ApiChecker.checkApi(response);
    }
  }

  ///=====================================Training Programs All============================

  RxList<TrainingProgramsData> trainingProgramsList =
      <TrainingProgramsData>[].obs;
  getTrainingProgramAll() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.trainingProgramAll);

    if (response.statusCode == 200) {
      trainingProgramsList.value = List<TrainingProgramsData>.from(
          response.body["data"].map((x) => TrainingProgramsData.fromJson(x)));
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

  ///==================================Search Method===============================
  search({required String search}) async {
    setRxRequestStatus(Status.loading);
    trainingProgramsList.refresh();
    var response = await ApiClient.getData(
        "${ApiUrl.trainingProgramAll}?searchTerm=$search");
    trainingProgramsList.refresh();
    if (response.statusCode == 200) {
      trainingProgramsList = RxList<TrainingProgramsData>.from(
          response.body["data"].map((x) => TrainingProgramsData.fromJson(x)));
      setRxRequestStatus(Status.completed);
      trainingProgramsList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

//// ========================== All API Here ==============================

  homeScreenAPIs() async {
    bool training = await getTrainingProgramm();

    bool communityPost = await getCommunityPost();

    if (training && communityPost) {
      setRxRequestStatus(Status.completed);
      refresh();
    }
  }

  @override
  void onInit() {
    homeScreenAPIs();
    getTrainingProgramAll();
    super.onInit();
  }
}
