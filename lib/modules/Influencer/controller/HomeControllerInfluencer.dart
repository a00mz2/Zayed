// ignore_for_file: file_names, unnecessary_overrides

import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/modules/Influencer/Data/InfluencerData.dart';

class HomeControllerInfluencer extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  RxInt statusCode = 200.obs;

  InfluencerData data = InfluencerData(Get.find());

  @override
  void onInit() {
    super.onInit();
    getDataProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //===================Data=======================

  var profileData = {}.obs;
  var listHistoryDeposit = [].obs;

  //======================API=====================

  getDataProfile() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataProfile();

    if (handlingData(response) == StatusRequest.success) {
      profileData.value = await response['data'];
      await getDataWallet();
    } else {
      statusRequest.value = handlingData(response);
      statusCode.value = handlingStatusCode(response);
    }
  }

  getDataWallet() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataWallet(type: "deposit");
    if (handlingData(response) == StatusRequest.success) {
      listHistoryDeposit.value = response['data']['history'] ?? [];
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }
}
