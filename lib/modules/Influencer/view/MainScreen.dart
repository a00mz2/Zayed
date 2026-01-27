// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Influencer/controller/MainControlIerInfluencer.dart';
import 'package:zayed/modules/Influencer/view/screen/HomeScreenInfluencer.dart';
import 'package:zayed/modules/Influencer/view/screen/ProfileScreenInfluencer.dart';
import 'package:zayed/modules/Influencer/view/screen/WalletScreenInfluencer.dart';

class MainScreen extends GetView<MainControlIerInfluencer> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreenInfluencer(),
      WalletScreenInfluencer(),
      ProfileScreenInfluencer(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (value) => controller.changePage(value),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xffCE0070),
          unselectedItemColor: Color(0xffA3A3A3),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                AppIcons.homeIcon,
                width: 24,
                height: 24,
                color: Color(0xffA3A3A3),
              ),

              activeIcon: Image.asset(AppIcons.homeIcon, width: 24, height: 24),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppIcons.waltIcon,
                width: 24,
                height: 24,
                color: Color(0xffA3A3A3),
              ),
              activeIcon: Image.asset(AppIcons.waltIcon, width: 24, height: 24),
              label: 'المحفظة',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppIcons.userCircle,
                width: 24,
                height: 24,
                color: Color(0xffA3A3A3),
              ),
              activeIcon: Image.asset(
                AppIcons.userCircle,
                width: 24,
                height: 24,
              ),
              label: 'الحساب',
            ),
          ],
        ),
      ),
    );
  }
}
