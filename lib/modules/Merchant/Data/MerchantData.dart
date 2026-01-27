// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:zayed/core/class/crud.dart';
import 'package:zayed/core/constant/size.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/linkApi.dart';

class MerchantData {
  Myservices myservices = Get.find();
  Crud crud;

  MerchantData(this.crud);

  Future<dynamic> getDataProfile() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.merchant}profile",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getDataHome() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.merchant}profile/dashboard",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> updataProfile(
    String storeName,
    String storeEmail,
    String addressText,
    String description,
    String coverType,
    Map location, {
    Uint8List? logo,
    Uint8List? cover,
  }) async {
    final Map<String, Uint8List> files = {};

    if (logo is Uint8List) {
      files["logo"] = logo;
    }
    if (cover is Uint8List) {
      files["cover"] = cover;
    }
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "PUT",
      url: "${Applink.merchant}profile",
      files: files,
      data: {
        "storeName": storeName,
        "storeEmail": storeEmail,
        "addressText": addressText,
        "description": description,
        "location": jsonEncode(location),
        "coverType": cover != null ? coverType : null,
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> changePassword(oldPassword, newPassword) async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.merchant}profile/change-password",
      data: {"oldPassword": oldPassword, "newPassword": newPassword},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getCategories({String? search, bool? isActive}) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.merchant}categories?search=${search ?? ""}&isActive=${isActive ?? ""}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> createCategories({
    required String name,
    required String description,
    required imageCategorie,
    bool? isActive,
  }) async {
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "POST",
      url: "${Applink.merchant}categories",
      files: {'imageCategorie': imageCategorie},
      data: {"name": name, "description": description, "isActive": isActive},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> updateCategories({
    required String name,
    required String description,
    imageCategorie,
    bool? isActive,
    required String id,
  }) async {
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "PUT",
      url: "${Applink.merchant}categories/$id",
      files: imageCategorie is Uint8List
          ? {'imageCategorie': imageCategorie}
          : {},
      data: {"name": name, "description": description, "isActive": isActive},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> reorder(data) async {
    var response = await crud.request(
      method: "PATCH",
      url: "${Applink.merchant}categories/reorder",
      data: data,
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> removeCategories(String id) async {
    var response = await crud.request(
      method: "DELETE",
      url: "${Applink.merchant}categories/$id",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }
  //================== Sub Categories ==================

  Future<dynamic> getSubCategories({categoryId}) async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.merchant}subCategories/parent/$categoryId",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> createSubCategories({
    required String name,
    required imageCategorie,
    bool? isActive,
    String? sortOrder,
    required String parentCategoryId,
  }) async {
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "POST",
      url: "${Applink.merchant}subCategories",
      files: {'imageSubCategory': imageCategorie},
      data: {
        "name": name,
        "isActive": isActive,
        "sortOrder": sortOrder ?? "",
        "parentCategoryId": parentCategoryId,
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> updateSubCategories({
    required String name,
    required imageCategorie,
    bool? isActive,
    String? sortOrder,
    required String id,
  }) async {
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "PUT",
      url: "${Applink.merchant}subCategories/$id",
      files: imageCategorie is Uint8List
          ? {'imageSubCategory': imageCategorie}
          : {},
      data: {"name": name, "isActive": isActive, "sortOrder": sortOrder ?? ""},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> removeSunCategories(String id) async {
    var response = await crud.request(
      method: "DELETE",
      url: "${Applink.merchant}subCategories/$id",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  //================== Product ==================

  Future<dynamic> getProduct({
    categoryId,
    String? search,
    bool? isActive,
    bool? isNewArrival,
    bool? isBestSeller,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    int? thisLimit,
    int? page = 1,
  }) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.merchant}product?subCategoryId=$categoryId&search=${search ?? ""}&page=${page}&limit=${thisLimit ?? limit}&isActive=${isActive ?? ""}&isNewArrival=${isNewArrival ?? ""}&isBestSeller=${isBestSeller ?? ""}&minPrice=${minPrice ?? ""}&maxPrice=${maxPrice ?? ""}&sortBy=${sortBy ?? ""}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> reorderProduct(data, subCategoryId) async {
    var response = await crud.request(
      method: "PATCH",
      url: "${Applink.merchant}product/reorder",
      data: {"subCategoryId": subCategoryId, "list": data},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> createProduct({
    required String name,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    bool? isNewArrival,
    bool? isBestSeller,
    bool? isActive,
    String? sortOrder,
    required List<Uint8List> productImages,
  }) async {
    final Map<String, Uint8List> files = {};

    for (final img in productImages) {
      files['productImages'] = img;
    }
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "POST",
      url: "${Applink.merchant}product",
      files: files,
      data: {
        "name": name,
        "description": description,
        "price": price,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "isNewArrival": isNewArrival,
        "isBestSeller": isBestSeller,
        "isActive": isActive,
        "sortOrder": sortOrder ?? "",
      },
    );

    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> updateProduct({
    required String name,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    bool? isNewArrival,
    bool? isBestSeller,
    bool? isActive,
    String? sortOrder,
    required List<Uint8List> productImages,
    required String id,
    required List<String> deletedImageIds,
  }) async {
    final Map<String, Uint8List> files = {};

    for (final img in productImages) {
      files['productImages'] = img;
    }
    var response = await crud.request(
      method: "MULTIPART",
      methodMultipart: "PUT",
      url: "${Applink.merchant}product/$id",
      files: files,
      data: {
        "name": name,
        "description": description,
        "price": price,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "isNewArrival": isNewArrival,
        "isBestSeller": isBestSeller,
        "isActive": isActive,
        "sortOrder": sortOrder ?? "",
        "deletedImageIds": jsonEncode(deletedImageIds),
      },
    );

    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> deleteProduct({required String id}) async {
    var response = await crud.request(
      method: "DELETE",
      url: "${Applink.merchant}product/$id",
      data: {},
    );

    return response.fold((failure) => failure, (data) => data);
  }

  //================staff===================================

  Future<dynamic> getStaff() async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.merchant}staff",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> createStaff(
    String name,
    String phone,
    String password,
  ) async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.merchant}staff",
      data: {
        "name": name,
        "phone": phone,
        "password": password,
        "permissions": {
          "canCreateInvoice": true,
          "canViewInvoices": true,
          "canViewStats": false,
        },
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> updateStaff(String name, String password, id) async {
    var response = await crud.request(
      method: "PUT",
      url: "${Applink.merchant}staff/$id",
      data: {
        "name": name,
        "password": password,
        "permissions": {
          "canCreateInvoice": true,
          "canViewInvoices": true,
          "canViewStats": false,
        },
      },
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> deleteStaff(String id) async {
    var response = await crud.request(
      method: "DELETE",
      url: "${Applink.merchant}staff/$id",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  //======================== Invoice ==========================
  Future<dynamic> verifyInvoice(String code) async {
    var response = await crud.request(
      method: "GET",
      url: "${Applink.merchant}invoice/verify/?code=${code}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> createInvoice(String code, String originalAmount) async {
    var response = await crud.request(
      method: "POST",
      url: "${Applink.merchant}invoice/",
      data: {"code": code, "originalAmount": originalAmount},
    );
    return response.fold((failure) => failure, (data) => data);
  }

  Future<dynamic> getInvoice({int? page, String? search}) async {
    var response = await crud.request(
      method: "GET",
      url:
          "${Applink.merchant}invoice/?page=${page}&limit=${limit}&search=${search}",
      data: {},
    );
    return response.fold((failure) => failure, (data) => data);
  }
}
