import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class DataCustomer {
  Myservices myservices = Get.find();
  Crud crud;

  DataCustomer(this.crud);

  Future<dynamic> getDataAccount() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.customer}me",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> updateDataAccount({
    name,
    email,
    location,
    customerAvatar,
  }) async {
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "PUT",
      url: "${Applink.customer}me",
      files: customerAvatar != null ? {'customerAvatar': customerAvatar} : null,
      data: {'name': name, 'email': email, 'location': location},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getSlide() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.customer}slide",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
