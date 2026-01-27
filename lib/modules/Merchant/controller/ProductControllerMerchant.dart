// ignore_for_file: unnecessary_overrides, avoid_print, invalid_use_of_protected_member

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/enum.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showConfirmationDialog.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';
import 'package:zayed/modules/Merchant/view/Widget/ProductWidget/FilterProductWidgetMerchant.dart';

class ProductControllerMerchant extends GetxController {
  final String categoryId;
  final String subCategoryId;
  final String subCategoryName;
  ProductControllerMerchant({
    required this.categoryId,
    required this.subCategoryId,
    required this.subCategoryName,
  });

  @override
  void onInit() async {
    super.onInit();
    searchController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    sortOrderController = TextEditingController();

    print("START ProductControllerMerchant");
    await getProduct();
  }

  @override
  void onClose() {
    super.onClose();
    print("STOP ProductControllerMerchant");
  }

  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestButtonAdd = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestdeleteProduct = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;

  MerchantData data = MerchantData(Get.find());

  //==================== filter var ================

  RxBool isFilter = false.obs;

  double sliderMin = 0.0;
  double sliderMax = 0.0;

  RxDouble minPriceValue = 0.0.obs;
  RxDouble maxPriceValue = 0.0.obs;

  RxBool activeFilter = true.obs;
  RxBool disabledFilter = false.obs;
  RxBool isNewArrivalFilter = false.obs;
  RxBool isBestSellerFilter = false.obs;

  //==================== controller =================

  var formstate = GlobalKey<FormState>().obs;

  late TextEditingController searchController;

  //---------------- add Product -------------------
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController sortOrderController;
  RxBool isActiveAdd = true.obs;
  RxBool isNewArrival = false.obs;
  RxBool isBestSeller = false.obs;

  //==================== var ======================
  RxBool orderMode = false.obs;
  RxBool isActiveGet = true.obs;
  RxList<Map<String, dynamic>> reorderPayload = <Map<String, dynamic>>[].obs;

  RxList<dynamic> images = <dynamic>[].obs;
  List<String> deletedImages = []; // لتخزين id فقط

  //==================== Data ======================
  var listProduct = [].obs;
  RxInt percent = 0.obs;
  RxInt maxAmount = 0.obs;

  //==================Function===================

  Timer? debounce;
  search() {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      getProduct();
    });
  }

  openFilter() {
    if (orderMode.value) {
      AppSnackBar.warning("يجب ايقاف وضع الترتيب اولاً");
      return;
    }

    showBottomSlideSheet(Get.context, FilterProductWidgetMerchant());
  }

  resetFilter() {
    Get.back();
    isFilter.value = false;
    minPriceValue = 0.0.obs;
    maxPriceValue = 0.0.obs;
    activeFilter = true.obs;
    disabledFilter = false.obs;
    isNewArrivalFilter = false.obs;
    isBestSellerFilter = false.obs;
    getProduct();
  }

  activateCancelOrderMode() async {
    if (isFilter.value) {
      AppSnackBar.warning("لا يمكن ترتيب العناصر في وضع التصفية");
      return;
    }

    if (orderMode.value == true) {
      if (reorderPayload.value.isNotEmpty) {
        bool? confirm = await showConfirmationDialog(
          Get.context,
          title: "هل أنت متأكد؟",
          subtitle:
              "سيتم تجاهل جميع التغييرات التي قمت بها. إذا رغبت في حفظ التغييرات، يرجى الضغط على حفظ قبل المتابعة. ",
          colorActivButton: Colors.red,
        );
        if (confirm == null || !confirm) {
          return;
        }
        reorderPayload.value = [];

        orderMode.value = !orderMode.value;
        getProduct();
      } else {
        orderMode.value = !orderMode.value;
      }
    } else {
      orderMode.value = !orderMode.value;
    }
  }

  void updateReorderPayload({required int start, required int end}) {
    for (int i = start; i <= end; i++) {
      final product = listProduct[i];
      final String id = product['_id'];
      final int sortOrder = i + 1;

      final index = reorderPayload.indexWhere((e) => e['id'] == id);

      if (index != -1) {
        // موجود → عدّل ترتيبه
        reorderPayload[index]['sortOrder'] = sortOrder;
      } else {
        // غير موجود → أضفه
        reorderPayload.add({'id': id, 'sortOrder': sortOrder});
      }
    }
    reorderPayload.sort((a, b) => a['sortOrder'].compareTo(b['sortOrder']));
  }

  void changedActiveAdd(AddToggleType type) {
    switch (type) {
      case AddToggleType.isActive:
        isActiveAdd.value = !isActiveAdd.value;
        break;
      case AddToggleType.disabledFilter:
        isActiveAdd.value = !isActiveAdd.value;
        break;

      case AddToggleType.isNewArrival:
        isNewArrival.value = !isNewArrival.value;
        break;

      case AddToggleType.isBestSeller:
        isBestSeller.value = !isBestSeller.value;
        break;
    }
  }

  void changedActiveFilter(AddToggleType type) {
    switch (type) {
      case AddToggleType.isActive:
        activeFilter.value = !activeFilter.value;
        break;
      case AddToggleType.disabledFilter:
        disabledFilter.value = !disabledFilter.value;
        break;

      case AddToggleType.isNewArrival:
        isNewArrivalFilter.value = !isNewArrivalFilter.value;
        break;

      case AddToggleType.isBestSeller:
        isBestSellerFilter.value = !isBestSellerFilter.value;
        break;
    }
  }

  double calculatePriceAfterDiscount({required int price}) {
    double discountValue = price * (percent.value / 100);
    if (maxAmount.value > 0 && discountValue > maxAmount.value) {
      discountValue = maxAmount.value.toDouble();
    }
    double finalPrice = price - discountValue;
    // حماية من القيم السالبة
    if (finalPrice < 0) finalPrice = 0;
    return finalPrice;
  }

  String getProductImage(int index) {
    final images = listProduct[index]['images'];
    if (images is List && images.isNotEmpty) {
      return images.first['url']?.toString() ?? "";
    }
    return "";
  }

  //===================api=====================

  getProduct() async {
    if (reorderPayload.value.isNotEmpty) {
      return;
    }
    if (isFilter.value) {
      getProductFilter(back: false);
      return;
    }

    statusRequest.value = StatusRequest.loading;
    var response = await data.getProduct(
      search: searchController.text,
      categoryId: subCategoryId,
      isActive: isActiveGet.value,
      thisLimit: 100000,
    );
    if (handlingData(response) == StatusRequest.success) {
      listProduct.value = response['data']['data'] ?? [];
      percent.value = response['data']['merchantDiscount']['percent'] ?? 0;
      maxAmount.value = response['data']['maxAmount'] ?? 0;
      sliderMax = response['data']['maxPriceInStore'].toDouble();
      maxPriceValue.value = roundUp(
        response['data']['maxPriceInStore'].toDouble(),
      );
      minPriceValue.value = roundUp(0.0);

      if (maxPriceValue.value == 0.0) {
        maxPriceValue.value = response['data']['maxPriceInStore'].toDouble();
      }
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  getProductFilter({bool back = true}) async {
    isFilter.value = true;
    if (reorderPayload.value.isNotEmpty) {
      reorderPayload.value.clear();
      getProduct();
      orderMode.value = false;
    }
    if (back) {
      statusRequestButton.value = StatusRequest.loading;
    } else {
      statusRequest.value = StatusRequest.loading;
    }
    var response = await data.getProduct(
      thisLimit: 100000,
      search: searchController.text,
      categoryId: subCategoryId,

      isActive: activeFilter.value == disabledFilter.value
          ? null
          : activeFilter.value,
      isBestSeller: isBestSellerFilter.value ? true : null,
      isNewArrival: isNewArrivalFilter.value ? true : null,
      maxPrice: roundUp(maxPriceValue.value),
      minPrice: roundUp(minPriceValue.value),
    );
    if (handlingData(response) == StatusRequest.success) {
      listProduct.value = response['data']['data'] ?? [];
      print(response['data']['total']);
      listProduct.refresh();
      if (back) {
        Get.back();
      }
    }

    if (back) {
      statusRequestButton.value = handlingData(response);
    } else {
      statusRequest.value = handlingData(response);
    }
  }

  reorder() async {
    statusRequestButton.value = StatusRequest.loading;
    var response = await data.reorderProduct(reorderPayload, subCategoryId);
    if (handlingData(response) == StatusRequest.success) {
      await getProduct();
      reorderPayload.value = [];
      orderMode.value = false;
      AppSnackBar.success(response['message']);
    } else {
      AppSnackBar.error(response['message'] ?? "");
    }
    statusRequestButton.value = handlingData(response);
  }

  createProduct({int? index}) async {
    if (images.isEmpty) {
      AppSnackBar.error("الرجاء اضافة صور على الاقل صورة واحدة للمنتج");
      return;
    }
    statusRequestButtonAdd.value = StatusRequest.loading;
    if (formstate.value.currentState!.validate()) {
      var response = await data.createProduct(
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        isActive: isActiveAdd.value,
        isNewArrival: isNewArrival.value,
        isBestSeller: isBestSeller.value,
        sortOrder: sortOrderController.text,
        productImages: images.cast<Uint8List>(),
      );

      if (handlingData(response) == StatusRequest.success) {
        AppSnackBar.success(response['message']);
        getProduct();
        Timer(const Duration(seconds: 1), () {
          Get.back(result: true);
        });
      } else {
        AppSnackBar.error(response['message'] ?? "");
      }
      print(response);
    } else {}
    statusRequestButtonAdd.value = StatusRequest.success;
  }

  updateProduct(int index) async {
    print(deletedImages);
    print(images);
    if (images.isEmpty) {
      AppSnackBar.error("الرجاء اضافة صور على الاقل صورة واحدة للمنتج");
      return;
    }
    statusRequestButtonAdd.value = StatusRequest.loading;
    if (formstate.value.currentState!.validate()) {
      var response = await data.updateProduct(
        id: listProduct[index]['_id'],
        deletedImageIds: deletedImages,
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        isActive: isActiveAdd.value,
        isNewArrival: isNewArrival.value,
        isBestSeller: isBestSeller.value,
        sortOrder: sortOrderController.text,
        productImages: images.whereType<Uint8List>().toList(),
      );
      if (handlingData(response) == StatusRequest.success) {
        AppSnackBar.success(response['message']);
        getProduct();
        Timer(const Duration(seconds: 1), () {
          Get.back(result: true);
        });
      } else {
        AppSnackBar.error(response['message'] ?? "");
        print(response['message']);
      }
      print(response);
    } else {}
    statusRequestButtonAdd.value = StatusRequest.success;
  }

  deleteProduct(id) async {
    bool? confirm = await showConfirmationDialog(
      Get.context,
      title:
          "هل تريد حذف (${listProduct.firstWhere((element) => element['_id'] == id)['name']}) ؟",
      subtitle: "هذا الإجراء نهائي ولا يمكن التراجع عنه.",
      colorActivButton: Colors.red,
    );
    if (confirm == null || !confirm) {
      return;
    }

    statusRequestdeleteProduct.value = StatusRequest.loading;
    var response = await data.deleteProduct(id: listProduct[0]['_id']);
    if (handlingData(response) == StatusRequest.success) {
      await getProduct();
      AppSnackBar.success(response['message']);
      statusRequestdeleteProduct.value = handlingData(response);
      Timer(const Duration(seconds: 1), () {
        Get.back(result: true);
      });
    } else {
      AppSnackBar.error(response['message'] ?? "");
    }
    statusRequestdeleteProduct.value = handlingData(response);
  }
}
