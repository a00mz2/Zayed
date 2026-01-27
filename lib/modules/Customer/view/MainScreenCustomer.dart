// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/modules/Customer/Controller/MainControlIerCustomer.dart';
import 'package:zayed/modules/Customer/view/screen/HomeScreenCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/CustomBottomBarCustomer.dart';
import 'package:zayed/view/Screen/DevelopmentModScrren.dart';

class MainScreenCustomer extends GetView<MainControlIerCustomer> {
  const MainScreenCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreenCustomer(),
      Text("data"),
      Text("data"),
      Text("data"),
      DevelopmentModScrren(),
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
              child: CustomBottomBarCustomer(),
            ),
          ),
        ],
      ),
    );
  }
}
