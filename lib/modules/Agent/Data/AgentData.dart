// ignore_for_file: camel_case_types

import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class AgentData {
  Myservices myservices = Get.find();
  Crud crud;

  AgentData(this.crud);

  Future<dynamic> getDataProfile() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.agent}profile",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getDataWallet({type, page = 1}) async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.agent}wallet?page=$page&limit=$limit",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> submitCode(code) async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.agent}wallet/withdrawal/submit",
      data: {"code": code},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> confirmCode(code, otp) async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.agent}wallet/withdrawal/confirm",
      data: {"code": code, "otp": otp},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> changePassword(oldPassword, newPassword) async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.agent}profile/change-password",
      data: {"oldPassword": oldPassword, "newPassword": newPassword},
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
