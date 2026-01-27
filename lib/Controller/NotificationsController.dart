// ignore_for_file: avoid_print, unnecessary_overrides, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Data/authData.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/snackbar.dart';

class NotificationsController extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestPagination = StatusRequest.success.obs;

  RxInt statusCode = 200.obs;

  AuthData authData = AuthData(Get.find());

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pagination();
      }
    });
    getData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // =====================var=====================

  final ScrollController scrollController = ScrollController();

  int page = 2;

  var notifications = [].obs;

  // =====================fun=====================

  getData() async {
    statusRequest.value = StatusRequest.loading;
    var response = await authData.getNotifications();

    if (handlingData(response) == StatusRequest.success) {
      await authData.readNotifications();
      notifications.value = response['data']['notifications'];
      unreadCount.value = 0;
      unreadCount.refresh();
      print(unreadCount.value);
    } else {
      AppSnackBar.error(response['message'] ?? "حدث خطأ ما");
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  pagination() async {
    statusRequestPagination.value = StatusRequest.loading;
    var response = await authData.getNotifications(page: page);
    if (handlingData(response) == StatusRequest.success) {
      notifications.value += response['data']['notifications'];
      if (response['data']['notifications'].length == 0) {
        AppSnackBar.info("تم جلب جميع البيانات");
      }
      page++;
    }
    statusRequestPagination.value = handlingData(response);
  }
}

RxInt unreadCount = 0.obs;
