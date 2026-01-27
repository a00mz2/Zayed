import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class StoreTypeDataCustomer {
  Myservices myservices = Get.find();
  Crud crud;

  StoreTypeDataCustomer(this.crud);

  Future<dynamic> getstoreType({int? page = 1, int? thLimit}) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.customer}storeType?page=${page}&limit=${thLimit ?? limit}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
