// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Agent/Data/AgentData.dart';

class HomeControllerAgent extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestPagination = StatusRequest.success.obs;

  RxInt statusCode = 200.obs;

  AgentData data = AgentData(Get.find());

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pagination();
      }
    });
    getDataWallet();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // =====================var=====================

  final ScrollController scrollController = ScrollController();

  int page = 2;
  RxInt balance = 0.obs;

  //===================Data=======================

  var profileData = {}.obs;
  var listHistoryMovements = [].obs;

  //======================API=====================

  getDataWallet() async {
    page = 2;
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataWallet();
    if (handlingData(response) == StatusRequest.success) {
      listHistoryMovements.value = response['data']['history'] ?? [];
      balance.value = response['data']['balance'] ?? 0;
    } else {
      listHistoryMovements.value = [];
      balance.value = 0;
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  pagination() async {
    statusRequestPagination.value = StatusRequest.loading;
    var response = await data.getDataWallet(page: page);
    if (handlingData(response) == StatusRequest.success) {
      listHistoryMovements.value += response['data']['history'];
      if (response['data']['history'].length == 0) {
        AppSnackBar.info("تم جلب جميع البيانات");
      }
      page++;
    }
    statusRequestPagination.value = handlingData(response);
  }
}
