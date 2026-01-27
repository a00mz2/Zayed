// ignore_for_file: deprecated_member_use

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Customer/Controller/MainControlIerCustomer.dart';

class CustomBottomBarCustomer extends GetView<MainControlIerCustomer> {
  const CustomBottomBarCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 99,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// 🔹 الشريط الأبيض
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffF6F6F6))),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    _BottomItem(
                      icon: AppIcons.homeIcon,
                      label: "الرئيسية",
                      isActive: controller.currentIndex.value == 0,
                      onTap: () => controller.changeTab(0),
                    ),
                    _BottomItem(
                      icon: AppIcons.waltIcon,
                      label: "المحفظة",
                      isActive: controller.currentIndex.value == 1,
                      onTap: () => controller.changeTab(1),
                    ),
                    _BottomItem(
                      icon: AppIcons.mapLocation,
                      label: "الموقع الحالي",
                      isActive: controller.currentIndex.value == 2,
                      onTap: () => controller.changeTab(2),
                    ),
                    _BottomItem(
                      icon: AppIcons.Subscriptions,
                      label: "الاشتراك",
                      isActive: controller.currentIndex.value == 3,
                      onTap: () => controller.changeTab(3),
                    ),
                    _BottomItem(
                      icon: AppIcons.userCircle,
                      label: "الحساب",
                      isActive: controller.currentIndex.value == 4,
                      onTap: () => controller.changeTab(4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final targetColor = isActive
        ? const Color(0xFFE60073)
        : Colors.grey.shade400;

    return Expanded(
      child: BouncingWidget(
        onPressed: onTap,
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
          tween: ColorTween(end: targetColor),
          builder: (context, color, child) {
            final c = color ?? targetColor;
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(icon, width: 24, height: 24, color: c),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: c,
                      fontSize: 9,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
