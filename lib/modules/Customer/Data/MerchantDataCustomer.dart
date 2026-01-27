import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class MerchantDataCustomer {
  Myservices myservices = Get.find();
  Crud crud;

  MerchantDataCustomer(this.crud);

  Future<dynamic> getMerchantFeatured({int? thLimit, int? page = 1}) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.customer}merchant/featured/?limit=${thLimit ?? limit}&page=${page}",
    );

    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getMerchantByStoreTypeId({
    required String? id,
    int? page = 1,
    int? thLimit,
  }) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.customer}merchant?storeTypeId=${id}&page=${page}&limit=${thLimit ?? limit}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getMerchantDetails(String id) async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.customer}merchant/detail/$id",
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getMerchantCategories(String id) async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.customer}merchant/$id/categories",
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getMerchantProducts(String id, {String? categoryId}) async {
    String url = "${Applink.customer}merchant/$id/products";
    if (categoryId != null) {
      url += "?categoryId=$categoryId";
    }
    var response = await crud.request(
      method: "GET",
      url: url,
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
