// ignore_for_file: file_names, unnecessary_overrides, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Agent/Data/AgentData.dart';

class ProfileControllerAgent extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;

  RxInt statusCode = 200.obs;

  AgentData data = AgentData(Get.find());

  @override
  void onInit() {
    super.onInit();
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
    getDataProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // =====================var=======================

  var obscureText1 = true.obs;
  var obscureText2 = true.obs;

  late TextEditingController oldPassController;
  late TextEditingController newPassController;

  var formstate = GlobalKey<FormState>().obs;

  //===================Data=======================

  var profileData = {}.obs;

  //====================Function====================

  showPassword(bool obscure) {
    if (obscure) {
      obscureText1.value = !obscureText1.value;
    } else {
      obscureText2.value = !obscureText2.value;
    }
  }

  //======================API=====================

  getDataProfile() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataProfile();
    if (handlingData(response) == StatusRequest.success) {
      profileData.value = response['data'];
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  changePassword() async {
    if (formstate.value.currentState!.validate()) {
      statusRequestButton.value = StatusRequest.loading;

      var response = await data.changePassword(
        oldPassController.text,
        newPassController.text,
      );
      if (handlingData(response) == StatusRequest.success) {
        oldPassController.text = "";
        newPassController.text = "";
        AppSnackBar.success(response['message']);
      } else if (handlingData(response) == StatusRequest.offlineFailure) {
        AppSnackBar.warning("لا يوجد اتصال بالشبكة");
      } else {
        AppSnackBar.error(response['message'] ?? "خطاء غير متوقع");
      }
      statusRequestButton.value = handlingData(response);
    }
  }
}
