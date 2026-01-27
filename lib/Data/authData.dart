import 'package:get/get.dart';
import 'package:zayed/core/class/DeviceUUIDService.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class AuthData {
  Myservices myservices = Get.find();
  Crud crud;

  AuthData(this.crud);

  Future<dynamic> sendOtp(String phone, type) async {
    var response = await crud.request(
      method: "POST",
      url: Applink.sendOtp,
      data: {
        "phone": phone,
        "type": type, //reset_password  , register
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> verifyOtp(String phone, type, code) async {
    var response = await crud.request(
      method: "POST",
      url: Applink.verifyOtp,
      data: {"phone": phone, "code": code, "type": type},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> register(String phone, password, name) async {
    var response = await crud.request(
      method: "POST",
      url: Applink.register,
      data: {
        "phone": phone,
        "password": password,
        "name": name,
        "deviceId": await DeviceUUID.getUUID(),
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> login(String phone, password) async {
    var response = await crud.request(
      method: "POST",
      url: Applink.login,
      data: {
        "phone": phone,
        "password": password,
        "deviceId": await DeviceUUID.getUUID(),
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> resetPassword(String phone, password) async {
    var response = await crud.request(
      method: "POST",
      url: Applink.resetPassword,
      data: {"phone": phone, "password": password},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> notificationToken(String token, role) async {
    var response = await crud.request(
      method: "PUT",
      url: "${Applink.server + role}/profile/notification-token",
      data: {"token": token},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> removeNotificationToken(String token, role) async {
    var response = await crud.request(
      method: "DELETE",
      url: "${Applink.server + role}/profile/notification-token",
      data: {"token": token},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getNotifications({type, page = 1}) async {
    String role = myservices.sharedPreferences.getString("role") ?? "agent";

    var response = await crud.request(
      method: "GET",
      url: "${Applink.server + role}/notification?page=$page&limit=$limit",
      data: {},
    );

    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> readNotifications() async {
    String role = myservices.sharedPreferences.getString("role") ?? "agent";

    var response = await crud.request(
      method: "PUT",
      url: "${Applink.server + role}/notification/read-all",
      data: {},
    );

    return response.fold((failure) => failure, (data) => data);
  }
}
