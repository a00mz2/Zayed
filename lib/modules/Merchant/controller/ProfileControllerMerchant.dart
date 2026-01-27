// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/openMapBottomSheet.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';
import 'package:zayed/view/Widget/widgetApp/MediaInput.dart';

class ProfileControllerMerchant extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestForm = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestButton = StatusRequest.success.obs;
  Rx<StatusRequest> statusRequestButtonadd = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;

  MerchantData data = MerchantData(Get.find());

  @override
  void onInit() {
    super.onInit();
    oldPassController = TextEditingController();
    newPassController = TextEditingController();

    storeNameController = TextEditingController();
    storeEmailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    getDataProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // =================Controller====================

  final mapController = MapController();

  /// الموقع الافتراضي (مثلاً بغداد)
  Rx<LatLng> selectedLocation = LatLng(33.3152, 44.3661).obs;

  late TextEditingController oldPassController;
  late TextEditingController newPassController;

  late TextEditingController storeNameController;
  late TextEditingController storeEmailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;

  // =====================var=======================

  var obscureText1 = true.obs;
  var obscureText2 = true.obs;

  var formstate = GlobalKey<FormState>().obs;

  Rxn<Uint8List> logo = Rxn<Uint8List>();
  Rxn<Uint8List> cover = Rxn<Uint8List>();
  var currentType = MediaType.image.obs;

  //===================Data=======================

  var profileData = {}.obs;

  //====================Function====================

  showPassword(bool obscure) {
    if (obscure) {
      obscureText1.value = !obscureText1.value;
    } else {
      obscureText2.value = !obscureText2.value;
    }
  }

  /// تعيين موقع جديد من الخريطة
  void setLocation(LatLng point) {
    selectedLocation.value = point;
  }

  /// جلب موقع المستخدم الحالي
  Future<void> getCurrentLocation() async {
    statusRequestButton.value = StatusRequest.loading;
    final pos = await determinePosition();
    selectedLocation.value = LatLng(pos.latitude, pos.longitude);

    mapController.move(selectedLocation.value, 16);
    statusRequestButton.value = StatusRequest.success;
  }

  /// إخراج الإحداثيات بالشكل المطلوب
  Map<String, double> get locationAsJson => {
    "lat": selectedLocation.value.latitude,
    "lng": selectedLocation.value.longitude,
  };

  setInitialLocationFromProfile() {
    storeNameController.text = profileData['storeName'];
    phoneController.text = profileData['phone'];
    if (profileData['storeEmail'] != null) {
      storeEmailController.text = profileData['storeEmail'];
    }
    if (profileData['coverType'] == "video") {
      currentType.value = MediaType.video;
    } else {
      currentType.value = MediaType.image;
    }
    addressController.text = profileData['addressText'];
    descriptionController.text = profileData['description'];

    final lat = profileData['location']?['lat'];
    final lng = profileData['location']?['lng'];

    if (lat == null || lng == null) return;

    final point = LatLng(lat.toDouble(), lng.toDouble());

    selectedLocation.value = point;

    try {
      mapController.move(point, 15);
    } catch (e) {
      print(e);
    }
  }

  //======================API=====================

  getDataProfile() async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.getDataProfile();
    if (handlingData(response) == StatusRequest.success) {
      profileData.value = response['data'];
    }
    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }

  changePassword() async {
    if (formstate.value.currentState!.validate()) {
      statusRequestButton.value = StatusRequest.loading;

      var response = await data.changePassword(
        oldPassController.text,
        newPassController.text,
      );
      if (handlingData(response) == StatusRequest.success) {
        oldPassController.text = "";
        newPassController.text = "";
        AppSnackBar.success(response['message']);
      } else if (handlingData(response) == StatusRequest.offlineFailure) {
        AppSnackBar.warning("لا يوجد اتصال بالشبكة");
      } else {
        AppSnackBar.error(response['message']);
      }
      statusRequestButton.value = handlingData(response);
    }
  }

  updataProfile() async {
    if (formstate.value.currentState!.validate()) {
      statusRequestButtonadd.value = StatusRequest.loading;
      var response = await data.updataProfile(
        storeNameController.text,
        storeEmailController.text,
        addressController.text,
        descriptionController.text,
        currentType.value == MediaType.video ? "video" : "image",
        locationAsJson,
        cover: cover.value,
        logo: logo.value,
      );

      if (handlingData(response) == StatusRequest.success) {
        await getDataProfile();
        await setInitialLocationFromProfile();
        AppSnackBar.success(response['message'] ?? "");
      } else {
        AppSnackBar.error(response['message'] ?? "");
      }
      statusRequestButtonadd.value = handlingData(response);
    }
  }
}
