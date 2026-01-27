// ignore_for_file: unnecessary_overrides, avoid_print, invalid_use_of_protected_member

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showConfirmationDialog.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';

class StaffControllerMerchant extends GetxController {
  MerchantData data = MerchantData(Get.find());

  @override
  void onInit() async {
    super.onInit();
    print("START StaffControllerMerchant");
    nameController = TextEditingController();
    passController = TextEditingController();
    phoneController = TextEditingController();
    getStaff();
  }

  @override
  void onClose() {
    super.onClose();
    print("STOP StaffControllerMerchant");
  }

  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;

  //====================controller=================

  var formstate = GlobalKey<FormState>().obs;

  //----------------add Category-------------------
  late TextEditingController nameController;
  late TextEditingController passController;
  late TextEditingController phoneController;
  Rxn<Uint8List> imageCategorie = Rxn<Uint8List>();

  //====================var======================

  RxInt indexDeleted = (-1).obs;
  RxBool obscureText = true.obs;

  //====================Data======================
  var listStaff = [].obs;

  //==================Function===================

  showPassword() {
    obscureText.value = !obscureText.value;
  }

  //===================api=====================
  getStaff() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getStaff();
    print(response);
    if (handlingData(response) == StatusRequest.success) {
      listStaff.value = response['data'] ?? [];
    } else {
      AppSnackBar.error(response['message']);
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  createStaff() async {
    if (formstate.value.currentState!.validate()) {
      statusRequestButton.value = StatusRequest.loading;
      var response = await data.createStaff(
        nameController.text,
        phoneController.text,
        passController.text,
      );
      if (handlingData(response) == StatusRequest.success) {
        getStaff();
        Get.back();
        AppSnackBar.success(response['message']);
        statusRequestButton.value = handlingData(response);
      } else {
        AppSnackBar.error(response['message'] ?? "خطاء غير معروف");
      }
      statusRequestButton.value = StatusRequest.success;
    } else {}
  }

  updateStaff(int index) async {
    if (formstate.value.currentState!.validate()) {
      statusRequestButton.value = StatusRequest.loading;
      var response = await data.updateStaff(
        nameController.text,
        passController.text,
        listStaff[index]['id'],
      );
      if (handlingData(response) == StatusRequest.success) {
        getStaff();
        AppSnackBar.success(response['message']);
        statusRequestButton.value = handlingData(response);
        Get.back();
      } else {
        AppSnackBar.error(response['message'] ?? "خطاء غير معروف");
      }
      statusRequestButton.value = StatusRequest.success;
    } else {}
  }

  deleteStaff(int index) async {
    bool? confirm = await showConfirmationDialog(
      Get.context,
      title: "هل تريد حذف حساب (${listStaff[index]['name']}) ؟",
      subtitle: "هذا الإجراء نهائي ولا يمكن التراجع عنه.",
      colorActivButton: Colors.red,
    );
    if (confirm == null || !confirm) {
      return;
    }

    indexDeleted.value = index;
    var response = await data.deleteStaff(listStaff[index]['id']);
    if (handlingData(response) == StatusRequest.success) {
      listStaff.removeAt(index);
      listStaff.refresh();
      AppSnackBar.success(response['message']);
    } else {
      AppSnackBar.error(response['message'] ?? "خطاء غير معروف");
    }
    indexDeleted.value = (-1);
  }
}
