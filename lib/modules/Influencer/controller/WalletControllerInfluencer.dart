// ignore_for_file: file_names, unnecessary_overrides, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Influencer/Data/InfluencerData.dart';
import 'package:zayed/modules/Influencer/view/Widget/WalletWidgets/withdrawalCodeFormWidget.dart';

class WalletControllerInfluencer extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestForm = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;

  InfluencerData data = InfluencerData(Get.find());

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

  RxString codeWithdrawalRequest = "".obs;
  RxInt balanceWallet = 0.obs;

  var obscureText1 = true.obs;
  var obscureText2 = true.obs;

  late TextEditingController oldPassController;
  late TextEditingController newPassController;

  var formstate = GlobalKey<FormState>().obs;

  //===================Data=======================

  var profileData = {}.obs;
  var listHistoryWithdraw = [].obs;

  //====================Function====================

  showPassword(bool obscure) {
    if (obscure) {
      obscureText1.value = !obscureText1.value;
    } else {
      obscureText2.value = !obscureText2.value;
    }
  }

  //======================API=====================

  withdrawalRequest(BuildContext context) async {
    statusRequestForm.value = StatusRequest.loading;
    showBottomSlideSheet(
      context,
      withdrawalCodeFormWidget(
        balanceWallet: balanceWallet.value,
        statusRequest: statusRequestForm,
        codeWithdrawalRequest: codeWithdrawalRequest,
        avatarUrl: profileData['avatarUrl'] ?? "",
        name: profileData['name'] ?? "",
      ),
      height: Get.size.height - 30,
    );

    var response = await data.withdrawalRequest();
    if (handlingData(response) == StatusRequest.success) {
      codeWithdrawalRequest.value = response['data']['code'];
    } else if (handlingData(response) == StatusRequest.offlineFailure) {
      Get.back();
      AppSnackBar.error("لا يوجد اتصال بالشبكة");
    } else {
      Get.back();
      AppSnackBar.error(response['message'] ?? "خطاء غير معروف");
    }
    statusRequestForm.value = handlingData(response);
    print(statusRequestForm.value);
  }

  getDataProfile() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataProfile();
    if (handlingData(response) == StatusRequest.success) {
      profileData.value = response['data'];
      getDataWallet();
    } else {
      statusRequest.value = handlingData(response);
      statusCode.value = handlingStatusCode(response);
    }
  }

  getDataWallet() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataWallet(type: "withdraw");
    if (handlingData(response) == StatusRequest.success) {
      listHistoryWithdraw.value = response['data']['history'];
      balanceWallet.value = response['data']['balance'] ?? 0;
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
        AppSnackBar.error(response['message']);
      }
      statusRequestButton.value = handlingData(response);
    }
  }
}
