// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/modules/Merchant/controller/MainControllerMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/CustomBottomBarMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/AllProductScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/HomeScrrenMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/InvoiceScreenInMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/ProfileScreenInMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/ScanCodeDiscountScrrenMerchant.dart';

class MainScreenMerchant extends GetView<MainControllerMerchant> {
  const MainScreenMerchant({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScrrenMerchant(),
      InvoiceScreenInMerchant(),
      ScanCodeDiscountScrrenMerchant(),
      AllProductScrrenMerchant(),
      ProfileScreenInMerchant(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// 🔹 الصفحات
          Obx(() => pages[controller.currentIndex.value]),

          /// 🔻 Bottom Bar
          SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomBarMerchant(),
            ),
          ),
        ],
      ),
    );
  }
}
