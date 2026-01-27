// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:zayed/Controller/NotificationsController.dart';
import 'package:zayed/Data/authData.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';

class MainControllerAgent extends GetxController {
  final currentIndex = 0.obs;

  AuthData authData = AuthData(Get.find());

  void changeTab(int index) {
    currentIndex.value = index;
  }

  getNnreadCountNotifications() async {
    var response = await authData.getNotifications();
    if (handlingData(response) == StatusRequest.success) {
      unreadCount.value = response['data']['unreadCount'] ?? 0;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNnreadCountNotifications();
  }
}
