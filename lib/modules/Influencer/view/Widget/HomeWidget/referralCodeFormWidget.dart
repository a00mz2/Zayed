// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class referralCodeFormWidget extends StatelessWidget {
  const referralCodeFormWidget({super.key, required this.referralCode});

  final String referralCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: InkWell(
                onTap: () => Get.back(),
                child: Row(children: [Icon(Icons.close)]),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "شارك رمز QR الخاص بك ",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(0xff0A0A0A),
              fontSize: 14,
              fontWeight: MyFontWeight.regular,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 290,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: SizedBox(
              width: 162,
              height: 162,
              child: PrettyQrView.data(
                data: referralCode,
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrShape.custom(
                    PrettyQrSquaresSymbol(),
                    finderPattern: PrettyQrSquaresSymbol(),
                    alignmentPatterns: PrettyQrSmoothSymbol(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "يمكن للمستخدمين مسح الرمز والحصول على الكوبون مباشرة",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(0xff575757),
              fontSize: 16,
              fontWeight: MyFontWeight.regular,
            ),
          ),
        ],
      ),
    );
  }
}
