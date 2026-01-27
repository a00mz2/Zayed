import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class DiscountGroupDataCustomer {
  Myservices myservices = Get.find();
  Crud crud;

  DiscountGroupDataCustomer(this.crud);

  Future<dynamic> getdiscountGroup() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.customer}discountGroup",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getMerchants({
    required String? id,
    int? page = 1,
    int? thLimit,
  }) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.customer}discountGroup/${id}/merchants?page=${page}&limit=${thLimit ?? limit}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
