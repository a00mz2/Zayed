import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/ScanCodeDiscountControllerMerchant.dart';

class ButtonToggleFlashWidgetMerchant extends StatelessWidget {
  ButtonToggleFlashWidgetMerchant({super.key});
  final controller = Get.find<ScanCodeDiscountControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => InkWell(
          onTap: controller.toggleFlash,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
            decoration: BoxDecoration(
              color: controller.isFlashOn.value
                  ? const Color(0xffA90067) // 🔴 تشغيل
                  : const Color.fromARGB(255, 232, 232, 232), // ⚪ إيقاف
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppIcons.flashlight,
                  width: 18,
                  height: 18,
                  color: controller.isFlashOn.value
                      ? Colors.white
                      : const Color(0xff6A7282),
                ),
                const SizedBox(width: 6),
                Text(
                  controller.isFlashOn.value ? "إيقاف الكشاف" : "تشغيل الكشاف",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: controller.isFlashOn.value
                        ? Colors.white
                        : const Color(0xff6A7282),
                    fontSize: 12,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
