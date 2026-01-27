// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Agent/Controller/MainControlIerAgent.dart';

class CustomBottomBarAgent extends GetView<MainControllerAgent> {
  const CustomBottomBarAgent({super.key});

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
                    icon: AppIcons.registerIcon,
                    label: "سجل العليات",
                    isActive: controller.currentIndex.value == 0,
                    onTap: () => controller.changeTab(0),
                  ),

                  Expanded(child: const SizedBox()),

                  _BottomItem(
                    icon: AppIcons.userCircle,
                    label: "الحساب",
                    isActive: controller.currentIndex.value == 1,
                    onTap: () => controller.changeTab(1),
                  ),
                ],
              ),
            ),
          ),

          /// 🔴 زر المنتصف (مطابق)
          Positioned(
            bottom: 33,
            child: InkWell(
              onTap: () => controller.changeTab(2),
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
    final color = isActive ? const Color(0xFFE60073) : Colors.grey.shade400;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, width: 24, height: 24, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: MyFontWeight.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
