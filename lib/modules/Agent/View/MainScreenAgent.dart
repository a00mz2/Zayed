import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/modules/Agent/Controller/MainControlIerAgent.dart';
import 'package:zayed/modules/Agent/View/Screen/HomeScreenAgent.dart';
import 'package:zayed/modules/Agent/View/Screen/ProfileScreenAgent.dart';
import 'package:zayed/modules/Agent/View/Screen/WithdrawalScreenAgent.dart';
import 'package:zayed/modules/Agent/View/widget/CustomBottomBarAgent.dart';

class MainScreenAgent extends GetView<MainControllerAgent> {
  const MainScreenAgent({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreenAgent(),
      ProfileScreenAgent(),
      WithdrawalScreenAgent(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 الصفحات
          Obx(() => pages[controller.currentIndex.value]),

          /// 🔻 Bottom Bar
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomBarAgent(),
            ),
          ),
        ],
      ),
    );
  }
}
