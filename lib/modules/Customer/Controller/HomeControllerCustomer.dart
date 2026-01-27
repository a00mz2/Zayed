// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/modules/Customer/Data/DataCustomer.dart';
import 'package:zayed/modules/Customer/Data/DiscountGroupDataCustomer.dart';
import 'package:zayed/modules/Customer/Data/MerchantDataCustomer.dart';
import 'package:zayed/modules/Customer/Data/storeTypeDataCustomer.dart';

class HomeControllerCustomer extends GetxController {
  DataCustomer dataCustomer = DataCustomer(Get.find());
  MerchantDataCustomer dataMerchantCustomer = MerchantDataCustomer(Get.find());
  StoreTypeDataCustomer dataStoreTypeCustomer = StoreTypeDataCustomer(
    Get.find(),
  );
  DiscountGroupDataCustomer discountGroupDataCustomer =
      DiscountGroupDataCustomer(Get.find());

  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestGradient = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestdataAccount = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestSliders = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestMerchant = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestStoreType = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestDiscountGroup = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestStoresByCatigory = StatusRequest.loading.obs;
  RxInt statusCode = 200.obs;

  @override
  void onInit() {
    super.onInit();
    getDataHome();
  }

  // ==================var=================
  RxInt sliderCurrent = 0.obs;

  //================data=================
  var dataAccount = {}.obs;
  var listSliders = [].obs;
  var listMerchant = [].obs;
  var listStoreType = [].obs;
  var listDiscountGroup = [].obs;
  //===========finction===================
  getDataHome() async {

    statusRequestGradient.value=StatusRequest.loading;
    statusRequestStoresByCatigory.value = StatusRequest.loading;
    listStoresByCatigory.clear();
    listStoresByCatigory.refresh();

    getdataAccount();
    getSliders();
    getMerchant();
    getdiscountGroup();
    await getstoreType();
    getStoresByCatigory();
  }

  //==================api================

  getdataAccount() async {
    var response = await dataCustomer.getDataAccount();
    if (handlingData(response) == StatusRequest.success) {
      dataAccount.value = response['data'];
    }
    statusRequestdataAccount.value = handlingData(response);
  }

  getSliders() async {
    // statusRequestSliders.value = StatusRequest.loading;
    var response = await dataCustomer.getSlide();
    if (handlingData(response) == StatusRequest.success) {
      listSliders.value = response['data'];
    }
    statusRequestSliders.value = handlingData(response);
  }

  getMerchant() async {
    // statusRequestMerchant.value = StatusRequest.loading;
    var response = await dataMerchantCustomer.getMerchantFeatured(thLimit: 7);
    if (handlingData(response) == StatusRequest.success) {
      listMerchant.value = response['data']['data'];
    }
    statusRequestMerchant.value = handlingData(response);
  }

  getstoreType() async {
     // statusRequestStoreType.value = StatusRequest.loading;

    var response = await dataStoreTypeCustomer.getstoreType(thLimit: 10);

    if (handlingData(response) == StatusRequest.success) {
      listStoreType.value = response['data']['data'] ?? [];
    } else {
      listStoreType.value = [];
    }

    statusRequestStoreType.value = handlingData(response);
    statusRequestGradient.value = StatusRequest.success;

  }

  getdiscountGroup() async {
    // statusRequestDiscountGroup.value = StatusRequest.loading;

    var response = await discountGroupDataCustomer.getdiscountGroup();

    if (handlingData(response) == StatusRequest.success) {
      listDiscountGroup.value = response['data'] ?? [];
    } else {
      listDiscountGroup.value = [];
    }
    statusRequestDiscountGroup.value = handlingData(response);
  }

  final RxList<Map<String, dynamic>> listStoresByCatigory =
      <Map<String, dynamic>>[].obs;

  Future<void> getStoresByCatigory() async {
    statusRequestStoresByCatigory.value = StatusRequest.loading;
    listStoresByCatigory.clear();
    listStoresByCatigory.refresh();

    final count = listStoreType.length < 5 ? listStoreType.length : 5;

    for (int i = 0; i < count; i++) {
      final response = await dataMerchantCustomer.getMerchantByStoreTypeId(
        id: listStoreType[i]["_id"].toString(),
        page: 1,
        thLimit: 5,
      );

      if (handlingData(response) == StatusRequest.success) {
        final data = response['data']?['data'];
        if (data is List && data.isNotEmpty) {
          listStoresByCatigory.add({
            "CatigoryName": listStoreType[i]['name'],
            "CatigoryId": listStoreType[i]['_id'],
            "data": data,
          });
        }
      }
    }

    listStoresByCatigory.refresh();

    statusRequestStoresByCatigory.value = StatusRequest.success;
  }
}
