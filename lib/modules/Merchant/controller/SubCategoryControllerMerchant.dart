// ignore_for_file: unnecessary_overrides, avoid_print, invalid_use_of_protected_member

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showConfirmationDialog.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';

class SubCategoryControllerMerchant extends GetxController {
  final String categoryId;
  final String categoryName;
  SubCategoryControllerMerchant({
    required this.categoryId,
    required this.categoryName,
  });
  @override
  void onInit() async {
    super.onInit();
    searchController = TextEditingController();
    nameController = TextEditingController();
    sortOrderController = TextEditingController();
    print("START SubCategoryControllerMerchant");
    getSubCategories();
  }

  @override
  void onClose() {
    super.onClose();
    print("STOP SubCategoryControllerMerchant");
  }

  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestButtonAdd = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;
  RxInt indexLoding = (-1).obs;

  MerchantData data = MerchantData(Get.find());

  //====================controller=================

  var formstate = GlobalKey<FormState>().obs;

  late TextEditingController searchController;
  //----------------add Category-------------------
  late TextEditingController nameController;
  late TextEditingController sortOrderController;
  RxBool isActiveAdd = true.obs;
  Rxn<Uint8List> imageCategorie = Rxn<Uint8List>();

  //====================var======================
  RxBool orderMode = false.obs;
  RxnBool isActiveGet = RxnBool();
  RxList<Map<String, dynamic>> reorderPayload = <Map<String, dynamic>>[].obs;

  //====================Data======================
  var listSubCategories = [].obs;

  //==================Function===================

  void addOrUpdateReorderItem(String id, int sortOrder) {
    final index = reorderPayload.indexWhere((e) => e['id'] == id);

    if (index != -1) {
      reorderPayload[index]['sortOrder'] = sortOrder;
    } else {
      reorderPayload.add({'id': id, 'sortOrder': sortOrder});
    }
    reorderPayload.sort((a, b) => a['sortOrder'].compareTo(b['sortOrder']));
  }

  changedActiveAdd() {
    isActiveAdd.value = !isActiveAdd.value;
  }
  //===================api=====================

  getSubCategories() async {
    indexLoding.value = -1;
    if (reorderPayload.value.isNotEmpty) {
      return;
    }
    statusRequest.value = StatusRequest.loading;
    var response = await data.getSubCategories(categoryId: categoryId);

    if (handlingData(response) == StatusRequest.success) {
      listSubCategories.value = response['data'] ?? [];
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  reorder() async {
    statusRequestButton.value = StatusRequest.loading;
    var response = await data.reorder(reorderPayload);
    if (handlingData(response) == StatusRequest.success) {
      await getSubCategories();
      reorderPayload.value = [];
      orderMode.value = false;
      AppSnackBar.success(response['message']);
    } else {
      AppSnackBar.error(response['message'] ?? "");
    }
    statusRequestButton.value = handlingData(response);
  }

  createSubCategories() async {
    if (formstate.value.currentState!.validate()) {
      if (imageCategorie.value == null) {
        return AppSnackBar.warning("يجب اضافة صورة ");
      }

      statusRequestButtonAdd.value = StatusRequest.loading;
      var response = await data.createSubCategories(
        name: nameController.text,
        imageCategorie: imageCategorie.value,
        isActive: isActiveAdd.value,
        sortOrder: sortOrderController.text,
        parentCategoryId: categoryId,
      );

      if (handlingData(response) == StatusRequest.success) {
        Get.back();
        AppSnackBar.success(response['message']);
        getSubCategories();
      } else {
        AppSnackBar.success(response['message'] ?? "خطاء اثناء اضافة القسم");
      }
      statusRequestButtonAdd.value = handlingData(response);
    }
  }

  updateCategories(String id) async {
    if (formstate.value.currentState!.validate()) {
      statusRequestButtonAdd.value = StatusRequest.loading;
      var response = await data.updateSubCategories(
        name: nameController.text,
        imageCategorie: imageCategorie.value ?? "",
        isActive: isActiveAdd.value,
        sortOrder: sortOrderController.text,
        id: id,
      );

      if (handlingData(response) == StatusRequest.success) {
        Get.back();
        AppSnackBar.success(response['message']);
        getSubCategories();
      } else {
        AppSnackBar.success(response['message'] ?? "خطاء اثناء تعديل القسم");
      }
      statusRequestButtonAdd.value = handlingData(response);
    }
  }

  removeSubCategories(String id) async {
    bool? confirm = await showConfirmationDialog(
      Get.context,
      title:
          "هل تريد حذف (${listSubCategories.firstWhere((element) => element['_id'] == id)['name']}) ؟",
      subtitle: "هذا الإجراء نهائي ولا يمكن التراجع عنه.",
      colorActivButton: Colors.red,
    );
    if (confirm == null || !confirm) {
      return;
    }

    indexLoding.value = listSubCategories.indexWhere(
      (element) => element['_id'] == id,
    );
    var response = await data.removeSunCategories(id);
    if (handlingData(response) == StatusRequest.success) {
      listSubCategories.removeWhere((element) => element['_id'] == id);
      listSubCategories.refresh();
      AppSnackBar.success(response['message']);
    } else {
      AppSnackBar.error(response['message'] ?? "");
    }
    indexLoding.value = -1;
  }
}
