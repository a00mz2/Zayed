// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/checkInternetConnection.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/core/services/services.dart';

class Crud {
  final _baseHeaders = {'Content-Type': 'application/json'};

  Future<Either<StatusRequest, Map>> request({
    required String method,
    required String url,
    dynamic data, // ✅ بدل Map
    Map<String, Uint8List>? files,
    bool isPublic = false,
    bool isRetry = false,
    String methodMultipart = "POST",
  }) async {
    if (!await checkInternetConnection()) {
      return const Left(StatusRequest.offlineFailure);
    }

    try {
      final token = myServices.sharedPreferences.getString('token');

      final headers = {
        ..._baseHeaders,
        if (!isPublic && token != null) 'Authorization': 'Bearer $token',
      };

      http.StreamedResponse response;

      // 🔍 اختيار نوع الطلب
      if (method.toUpperCase() == 'MULTIPART') {
        response = await _sendMultipart(
          url,
          headers,
          data ?? {},
          files ?? {},
          methodMultipart,
        );
      } else {
        response = await _sendStandard(url, headers, data, method);
      }

      // 📦 قراءة الرد
      String body = await response.stream.bytesToString();
      Map<String, dynamic> decoded;

      try {
        decoded = jsonDecode(body);
      } catch (_) {
        decoded = {"raw": body};
      }

      if ((response.statusCode == 401 || response.statusCode == 403) &&
          !isRetry &&
          !isPublic) {
        if (await _refreshToken()) {
          return await request(
            method: method,
            url: url,
            data: data,
            files: files,
            isRetry: true,
          );
        } else {
          _endSession();
          return Right({...decoded, "statusRequest": StatusRequest.failure});
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right({
          ...decoded,
          "statusRequest": StatusRequest.success,
          "statusCode": response.statusCode,
        });
      }

      return Right({
        ...decoded,
        "statusRequest": StatusRequest.failure,
        "statusCode": response.statusCode,
      });
    } catch (e) {
      if (kDebugMode) print("❌ CRUD Error: $e");
      return const Left(StatusRequest.failure);
    }
  }

  Future<http.StreamedResponse> _sendStandard(
    String url,
    Map<String, String> headers,
    dynamic data, // ✅
    String method,
  ) async {
    var request = http.Request(method.toUpperCase(), Uri.parse(url));

    if (data != null) {
      request.body = jsonEncode(data);
    }

    request.headers.addAll(headers);
    return await request.send();
  }

  Future<http.StreamedResponse> _sendMultipart(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> fields,
    Map<String, Uint8List> files,
    String methodMultipart,
  ) async {
    var request = http.MultipartRequest(methodMultipart, Uri.parse(url));

    // الحقول
    fields.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // الملفات (قد تكون فارغة)
    for (var entry in files.entries) {
      final compressed = await _compressImage(entry.value);
      request.files.add(
        http.MultipartFile.fromBytes(
          entry.key,
          compressed,
          filename: "${entry.key}_${DateTime.now().millisecondsSinceEpoch}.jpg",
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    request.headers.addAll(headers);
    return await request.send();
  }

  Future<Uint8List> _compressImage(Uint8List data) async {
    try {
      final decoded = img.decodeImage(data);
      if (decoded == null) return data;
      return Uint8List.fromList(img.encodeJpg(decoded, quality: 85));
    } catch (_) {
      return data;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = myServices.sharedPreferences.getString(
        "refreshToken",
      );
      if (refreshToken == null) return false;

      final res = await http.post(
        //غيرهة حط رابط صفحة تجديد التوكن
        Uri.parse("Applink.CustomersRefreshToken"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);

        await myServices.sharedPreferences.setString(
          "Token",
          decoded["accessToken"],
        );

        await myServices.sharedPreferences.setString(
          "refreshToken",
          decoded["refreshToken"],
        );

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  void _endSession() {
    myServices.sharedPreferences.clear();
    myServices.sharedPreferences.setString("router", "/");
    if (Get.currentRoute == "/Login") {
    } else {
      if (Get.currentRoute == "/") return;
      Get.offAllNamed("/");
      AppSnackBar.warning("تم تسجيل دخول من جهاز اخر");
      AppSnackBar.warning("انتهت صلاحية الجلسة");
    }
  }
}
