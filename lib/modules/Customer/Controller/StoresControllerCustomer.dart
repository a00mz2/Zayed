// ignore_for_file: unnecessary_overrides, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/modules/Customer/Data/DiscountGroupDataCustomer.dart';
import 'package:zayed/modules/Customer/Data/MerchantDataCustomer.dart';

class StoresControllerCustomer extends GetxController {
  MerchantDataCustomer dataMerchantCustomer = MerchantDataCustomer(Get.find());
  DiscountGroupDataCustomer dataDiscountGroup = DiscountGroupDataCustomer(
    Get.find(),
  );

  final StoresControllerCustomerModel model;
  StoresControllerCustomer({required this.model});

  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestPagination = StatusRequest.success.obs;

  RxInt statusCode = 200.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    getMerchant();
  }

  // ==================var=================
  RxInt sliderCurrent = 0.obs;

  //================pagnation============

  int page = 1;
  late ScrollController scrollController;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;

  //================data=================
  var listMerchant = [].obs;

  //===========finction===================

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (isLoadingMore.value || !hasMore.value) return;

    final position = scrollController.position;

    // ✅ فقط عند نهاية التمرير (user stopped) + وصل فعليًا للنهاية
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
      await getMerchant(append: true);
    } finally {
      isLoadingMore.value = false;
    }
  }

  //==================api================

  getMerchant({bool append = false}) async {
    if (append) {
      statusRequestPagination.value = StatusRequest.loading;
    } else {
      page = 1;
      hasMore.value = true;
      statusRequest.value = StatusRequest.loading;
    }
    var response;

    if (model.typePageStores == TypePageStores.featured) {
      response = await dataMerchantCustomer.getMerchantFeatured(
        page: append ? page : 1,
        thLimit: 20,
      );
    } else if (model.typePageStores == TypePageStores.byStoreType) {
      response = await dataMerchantCustomer.getMerchantByStoreTypeId(
        id: model.storeTypeId,
        page: append ? page : 1,
        thLimit: 20,
      );
    } else if (model.typePageStores == TypePageStores.discountGroup) {
      response = await dataDiscountGroup.getMerchants(
        id: model.discountGroupId,
        page: append ? page : 1,
        thLimit: 20,
      );
    }
    if (handlingData(response) == StatusRequest.success) {
      List items = (response['data']['data'] ?? []) as List;

      if (append) {
        listMerchant.addAll(items);
        if (items.isEmpty) {
          hasMore.value = false;
        }
      } else {
        listMerchant.value = items;
      }
    }
    statusRequest.value = handlingData(response);
    statusRequestPagination.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }
}

class StoresControllerCustomerModel {
  final TypePageStores typePageStores;
  final String? storeTypeId;
  final String? discountGroupId;
  const StoresControllerCustomerModel({
    required this.typePageStores,
    this.storeTypeId,
    this.discountGroupId,
  });
}

enum TypePageStores { featured, byStoreType, discountGroup }


// Get.toNamed(
//         "/customer/Stores",
//         arguments: {
//           "namePage": "المتاجر المضافة حديثا",
//           "model": StoresControllerCustomerModel(
//             typePageStores: TypePageStores.featured,
//           ),
//    },
//  ),