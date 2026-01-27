// ignore_for_file: camel_case_types

import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class InfluencerData {
  Myservices myservices = Get.find();
  Crud crud;

  InfluencerData(this.crud);

  Future<dynamic> getDataProfile() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.influencer}profile",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getDataWallet({type, page = 1}) async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.influencer}wallet?type=$type&page=$page&limit=$limit",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> withdrawalRequest() async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.influencer}wallet/withdraw",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> changePassword(oldPassword, newPassword) async {
    var response = await crud.request(
      method: "PUT",
      url: "${Applink.influencer}profile/change-password",
      data: {"oldPassword": oldPassword, "newPassword": newPassword},
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
