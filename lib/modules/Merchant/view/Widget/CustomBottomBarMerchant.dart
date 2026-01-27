// ignore_for_file: deprecated_member_use

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/MainControllerMerchant.dart';

class CustomBottomBarMerchant extends GetView<MainControllerMerchant> {
  const CustomBottomBarMerchant({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BottomItem(
                    icon: AppIcons.homeIcon,
                    label: "الرئيسية",
                    isActive: controller.currentIndex.value == 0,
                    onTap: () => controller.changeTab(0),
                  ),
                  // Expanded(child: const SizedBox()),
                  _BottomItem(
                    icon: AppIcons.registerIcon,
                    label: "الفواتير",
                    isActive: controller.currentIndex.value == 1,
                    onTap: () => controller.changeTab(1),
                  ),

                  Expanded(flex: 4, child: const SizedBox()),

                  _BottomItem(
                    icon: AppIcons.fireDiscount,
                    label: "المنتجات",
                    isActive: controller.currentIndex.value == 3,
                    onTap: () => controller.changeTab(3),
                  ),
                  // Expanded(child: const SizedBox()),
                  Expanded(
                    flex: 3,
                    child: _BottomItem(
                      icon: AppIcons.userCircle,
                      label: "الحساب",
                      isActive: controller.currentIndex.value == 4,
                      onTap: () => controller.changeTab(4),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔴 زر المنتصف (مطابق)
          Positioned(
            bottom: 33,
            child: BouncingWidget(
              scaleFactor: 2,
              onPressed: () => controller.changeTab(2),
              child: Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFCE0070),
                      Color(0xFFFF61B7),
                      Color(0xFFCE0070),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 26,
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
      flex: 3,
      child: BouncingWidget(
        scaleFactor: 1,
        onPressed: onTap,
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
          tween: ColorTween(end: targetColor),
          builder: (context, color, child) {
            final c = color ?? targetColor;
            return Center(
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
