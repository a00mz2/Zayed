// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:zayed/Data/authData.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/services/services.dart';

Future<void> logout() async {
  statusRequestLogout.value = StatusRequest.loading;

  AuthData data = AuthData(Get.find());
  String? role = myServices.sharedPreferences.getString("role");
  String? fcmToken = myServices.sharedPreferences.getString("FcmToken");

  var response = await data.removeNotificationToken(
    fcmToken ?? "noFcmToken",
    role,
  );

  statusRequestLogout.value = handlingData(response);

  await myServices.sharedPreferences.clear();
  Get.offAllNamed("/Login");
}

Rx<StatusRequest> statusRequestLogout = StatusRequest.success.obs;
