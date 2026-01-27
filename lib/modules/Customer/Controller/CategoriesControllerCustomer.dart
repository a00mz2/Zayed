// ignore_for_file: unnecessary_overrides, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/modules/Customer/Data/storeTypeDataCustomer.dart';

class CategoriesControllerCustomer extends GetxController {
  StoreTypeDataCustomer dataStoreType = StoreTypeDataCustomer(Get.find());

  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestPagination = StatusRequest.success.obs;

  RxInt statusCode = 200.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    getCategories();
  }

  // ==================var=================
  RxInt sliderCurrent = 0.obs;

  //================pagnation============

  int page = 1;
  late ScrollController scrollController;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;

  //================data=================
  var listStoreType = [].obs;

  //===========finction===================

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (isLoadingMore.value || !hasMore.value) return;
    final position = scrollController.position;
    if (position.atEdge && position.pixels == position.maxScrollExtent) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) return;
    if (!hasMore.value) return;

    isLoadingMore.value = true;
    try {
      page += 1;
      statusRequestPagination.value = StatusRequest.loading;
      await getCategories(append: true);
    } finally {
      isLoadingMore.value = false;
    }
  }

  //==================api================

  getCategories({bool append = false}) async {
    if (append) {
      statusRequestPagination.value = StatusRequest.loading;
    } else {
      page = 1;
      hasMore.value = true;
      statusRequest.value = StatusRequest.loading;
    }
    var response;

    response = await dataStoreType.getstoreType(
      page: append ? page : 1,
      thLimit: 20,
    );

    if (handlingData(response) == StatusRequest.success) {
      List items = (response['data']['data'] ?? []) as List;

      if (append) {
        listStoreType.addAll(items);
        if (items.isEmpty) {
          hasMore.value = false;
        }
      } else {
        listStoreType.value = items;
      }
    }
    statusRequest.value = handlingData(response);
    statusRequestPagination.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }
}
