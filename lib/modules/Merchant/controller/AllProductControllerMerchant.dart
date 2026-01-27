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
import 'package:zayed/modules/Merchant/view/Widget/AllProductWidget/FilterAllProductWidgetMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/AllProductWidget/SortByAllProductWidgetMerchant.dart';

class AllProductControllerMerchant extends GetxController {
  //==================== Status ====================
  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestButtonAdd = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestdeleteProduct = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestSubCategories = StatusRequest.loading.obs;
  RxInt statusCode = 200.obs;

  //==================== Data Layer =================
  MerchantData data = MerchantData(Get.find());

  //==================== Pagination ======================
  int page = 1;
  final int limit = 20;

  RxBool hasMore = true.obs;
  RxBool isLoadingMore = false.obs;

  // اختياري إذا تريد ربط سكرول داخل الكونترولر
  late ScrollController scrollController;

  //==================== Filter var =================
  RxBool isFilter = false.obs;

  double sliderMin = 0.0;
  double sliderMax = 0.0;

  RxDouble minPriceValue = 0.0.obs;
  RxDouble maxPriceValue = 0.0.obs;

  RxBool activeFilter = true.obs;
  RxBool disabledFilter = false.obs;
  RxBool isNewArrivalFilter = false.obs;
  RxBool isBestSellerFilter = false.obs;

  //==================== Controllers =================
  var formstate = GlobalKey<FormState>().obs;

  late TextEditingController searchController;

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController sortOrderController;

  RxBool isActiveAdd = true.obs;
  RxBool isNewArrival = false.obs;
  RxBool isBestSeller = false.obs;

  //==================== Order & Images =================
  RxBool isActiveGet = true.obs;

  RxList<dynamic> images = <dynamic>[].obs;
  List<String> deletedImages = [];

  //==================== Products ======================
  var listProduct = [].obs;
  RxInt percent = 0.obs;
  RxInt maxAmount = 0.obs;
  RxnString sortBy = RxnString();

  //==================== Categorie ======================
  var listCategories = [].obs;
  var listSubCategories = [].obs;

  Rxn<Map> selectedCategories = Rxn();
  Rxn<Map> selectedSubCategories = Rxn();

  //==================== Debounce ======================
  Timer? debounce;

  //==================== Lifecycle ======================
  @override
  void onInit() {
    super.onInit();
    _initControllers();

    scrollController = ScrollController();
    scrollController.addListener(_onScroll);

    getProduct();
  }

  @override
  void onClose() {
    debounce?.cancel();
    scrollController.dispose();
    _disposeControllers();
    super.onClose();
  }

  initPageAdd(index) async {
    images.clear();
    deletedImages.clear();

    if (index != null) {
      for (var img in listProduct[index!]['images']) {
        images.add(img);
      }

      final cat = await listCategories.cast().firstWhere(
        (e) => e['_id'] == listProduct[index!]["categoryId"],
        orElse: () => null, // ✅
      );

      selectedCategories.value = await cat;

      getSubCategories(selectedCategories.value!['_id'], index: index);

      nameController.text = listProduct[index!]['name'];
      priceController.text = listProduct[index!]['price'].toString();
      descriptionController.text = listProduct[index!]['description'];
      sortOrderController.text = listProduct[index!]['sortOrder'].toString();
      isActiveAdd.value = listProduct[index!]['isActive'];
      isNewArrival.value = listProduct[index!]['isNewArrival'];
      isBestSeller.value = listProduct[index!]['isBestSeller'];
    } else {
      images.clear();
      deletedImages.clear();
      nameController.text = "";
      priceController.text = "";
      descriptionController.text = "";
      sortOrderController.text = "";
      isActiveAdd.value = true;
      isNewArrival.value = false;
      isBestSeller.value = false;
      selectedCategories.value = null;
      selectedSubCategories.value = null;
      listSubCategories.value = [];
      statusRequestSubCategories.value = StatusRequest.success;
    }
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (isLoadingMore.value || !hasMore.value) return; // ✅ مهم

    final threshold = 250.0;
    final maxScroll = scrollController.position.maxScrollExtent;
    final current = scrollController.position.pixels;

    if (maxScroll - current <= threshold) {
      loadMore();
    }
  }

  void _initControllers() {
    searchController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    sortOrderController = TextEditingController();
  }

  void _disposeControllers() {
    searchController.dispose();
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    sortOrderController.dispose();
  }

  //================== UI Helpers ===================
  search() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      getProduct();
    });
  }

  openFilter() {
    showBottomSlideSheet(Get.context, FilterAllProductWidgetMerchant());
  }

  openSortBy() {
    showBottomSlideSheet(Get.context, SortByAllProductWidgetMerchant());
  }

  resetFilter() {
    Get.back();
    isFilter.value = false;

    minPriceValue.value = 0.0;
    maxPriceValue.value = 0.0;

    activeFilter.value = true;
    disabledFilter.value = false;
    isNewArrivalFilter.value = false;
    isBestSellerFilter.value = false;

    getProduct();
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) return; // ✅ مهم جداً
    if (!hasMore.value) return;

    page += 1;
    await _fetchProducts(backButtonLoading: false, append: true);
    print(
      "LOAD MORE => page=$page, loading=${isLoadingMore.value}, hasMore=${hasMore.value}",
    );
  }

  //================== Toggles ===================
  void changedActiveAdd(AddToggleType type) {
    switch (type) {
      case AddToggleType.isActive:
        isActiveAdd.value = !isActiveAdd.value;
        break;
      case AddToggleType.disabledFilter:
        // نفس سلوكك الحالي (مع أنه اسمها disabledFilter)
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

  //================== Calculations ===================
  double calculatePriceAfterDiscount({required int price}) {
    double discountValue = price * (percent.value / 100);
    if (maxAmount.value > 0 && discountValue > maxAmount.value) {
      discountValue = maxAmount.value.toDouble();
    }
    double finalPrice = price - discountValue;
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

  //=================== API Core =====================
  Map<String, dynamic> _buildQueryParams() {
    final params = <String, dynamic>{
      "search": searchController.text,
      "categoryId": "",
      "page": page,
      "limit": limit,
      "thisLimit": limit,
      "sortBy": sortBy.value ?? "",
    };

    if (!isFilter.value) {
      params["isActive"] = isActiveGet.value;
      return params;
    }

    params["isActive"] = (activeFilter.value == disabledFilter.value)
        ? null
        : activeFilter.value;

    params["isBestSeller"] = isBestSellerFilter.value ? true : null;
    params["isNewArrival"] = isNewArrivalFilter.value ? true : null;

    params["maxPrice"] = roundUp(maxPriceValue.value);
    params["minPrice"] = roundUp(minPriceValue.value);

    return params;
  }

  Future<void> _fetchProducts({
    required bool backButtonLoading,
    bool reset = false,
    bool append = false,
  }) async {
    if (reset) {
      page = 1;
      hasMore.value = true;
      listProduct.clear();
    }

    if (append) {
      if (isLoadingMore.value || !hasMore.value) return;
      isLoadingMore.value = true;
    } else {
      if (backButtonLoading) {
        statusRequestButton.value = StatusRequest.loading;
      } else {
        statusRequest.value = StatusRequest.loading;
      }
    }

    final p = _buildQueryParams();

    final response = await data.getProduct(
      search: p["search"],
      categoryId: p["categoryId"],
      isActive: p["isActive"],
      isBestSeller: p["isBestSeller"],
      isNewArrival: p["isNewArrival"],
      maxPrice: p["maxPrice"],
      minPrice: p["minPrice"],
      sortBy: p['sortBy'],
      page: p["page"],
      thisLimit: p["thisLimit"],
    );

    final st = handlingData(response);

    // ✅ 1) حدّث listProduct أولاً إذا نجاح
    if (st == StatusRequest.success) {
      final List items = (response['data']['data'] ?? []) as List;

      if (append) {
        listProduct.addAll(items);
      } else {
        listProduct.value = items;
      }

      // بيانات الخصم/السلايدر
      percent.value = response['data']['merchantDiscount']?['percent'] ?? 0;
      maxAmount.value = response['data']['maxAmount'] ?? 0;

      final maxPriceInStore = (response['data']['maxPriceInStore'] ?? 0)
          .toDouble();
      sliderMax = maxPriceInStore;

      if (maxPriceValue.value == 0.0 || !isFilter.value) {
        maxPriceValue.value = roundUp(maxPriceInStore);
        minPriceValue.value = roundUp(0.0);
        if (maxPriceValue.value == 0.0) maxPriceValue.value = maxPriceInStore;
      }

      final hasNext = response['data']['pagination']?['hasNext'];
      if (hasNext is bool) {
        hasMore.value = hasNext;
      } else {
        hasMore.value = items.length == limit;
      }

      listProduct.refresh();

      // ✅ 2) (اختياري) إجبار Flutter يكمّل رسم التحديث قبل تغيير statusRequest
      await Future.delayed(Duration.zero);
    }

    // ✅ 3) بعدها حدّث statusRequest
    if (append) {
      isLoadingMore.value = false;
    } else {
      if (backButtonLoading) {
        statusRequestButton.value = st;
      } else {
        statusRequest.value = st;
      }
      statusCode.value = handlingStatusCode(response);
    }
  }

  //=================== API Public =====================
  getProduct() async {
    getCategories();

    if (isFilter.value) {
      getProductFilter(back: false);
      return;
    }
    await _fetchProducts(backButtonLoading: false, reset: true);
  }

  getProductFilter({bool back = true}) async {
    isFilter.value = true;
    await _fetchProducts(backButtonLoading: back, reset: true);

    if (back) Get.back();
  }

  //=================== Delete =====================
  deleteProduct(id) async {
    bool? confirm = await showConfirmationDialog(
      Get.context,
      title:
          "هل تريد حذف (${listProduct.firstWhere((e) => e['_id'] == id)['name']}) ؟",
      subtitle: "هذا الإجراء نهائي ولا يمكن التراجع عنه.",
      colorActivButton: Colors.red,
    );
    if (confirm == null || !confirm) return;

    statusRequestdeleteProduct.value = StatusRequest.loading;

    final response = await data.deleteProduct(id: id);

    if (handlingData(response) == StatusRequest.success) {
      await getProduct();
      AppSnackBar.success(response['message']);
      Timer(const Duration(seconds: 1), () {
        Get.back(result: true);
      });
    } else {
      AppSnackBar.error(response['message'] ?? "");
    }

    statusRequestdeleteProduct.value = handlingData(response);
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
        categoryId: selectedCategories.value!["_id"],
        subCategoryId: selectedSubCategories.value!['_id'],
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
        categoryId: selectedCategories.value!["_id"],
        subCategoryId: selectedSubCategories.value!['_id'],
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

  //==================== Categorie ======================

  getCategories() async {
    var response = await data.getCategories(isActive: true);

    if (handlingData(response) == StatusRequest.success) {
      listCategories.value = response['data'] ?? [];
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  getSubCategories(categoryId, {int? index}) async {
    statusRequestSubCategories.value = StatusRequest.loading;

    var response = await data.getSubCategories(categoryId: categoryId);

    if (handlingData(response) == StatusRequest.success) {
      listSubCategories.value = response['data'] ?? [];
      selectedSubCategories.value = null;

      if (index != null) {
        selectedSubCategories.value = await listSubCategories.cast().firstWhere(
          (e) => e['_id'] == listProduct[index]["subCategoryId"],
          orElse: () => null,
        );
      }
    }
    statusRequestSubCategories.value = handlingData(response);
  }
}
