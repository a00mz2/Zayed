// ignore_for_file: depend_on_referenced_packages, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/modules/Merchant/controller/AllProductControllerMerchant.dart';

class SortByAllProductWidgetMerchant extends StatelessWidget {
  SortByAllProductWidgetMerchant({super.key});

  final controller = Get.find<AllProductControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 24,
            child: Center(
              child: Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: Color(0xffD4D4D8),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 36,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الترتيب حسب",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff3F3F46),
                      fontSize: 16,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              children: [
                _radioItem(
                  title: "السعر: من الأقل إلى الأعلى",
                  value: "priceLow",
                  sortBy: controller.sortBy,
                  onChanged: (_) => controller.getProduct(),
                ),
                const Divider(height: 1, color: Color(0xffF4F4F5)),
                _radioItem(
                  title: "السعر: من الأعلى إلى الأقل",
                  value: "priceHigh",
                  sortBy: controller.sortBy,
                  onChanged: (_) => controller.getProduct(),
                ),
                const Divider(height: 1, color: Color(0xffF4F4F5)),
                _radioItem(
                  title: "الأكثر مبيعاً",
                  value: "bestSeller",
                  sortBy: controller.sortBy,
                  onChanged: (_) => controller.getProduct(),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _radioItem({
    required String title,
    required String value,
    required RxnString sortBy,
    void Function(String? v)? onChanged,
  }) {
    return InkWell(
      onTap: () {
        sortBy.value = (sortBy.value == value) ? null : value;
        onChanged?.call(sortBy.value);
      },
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            Obx(
              () => Transform.scale(
                scale: 1.25,
                child: Radio<String>(
                  value: value,
                  groupValue: sortBy.value,
                  toggleable: true,
                  onChanged: (v) {
                    sortBy.value = v;
                    onChanged?.call(sortBy.value);
                  },
                  activeColor: const Color(0xffCE0070),
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    if (states.contains(WidgetState.selected)) {
                      return Color(0xffCE0070);
                    }
                    return Colors.grey.shade400;
                  }),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
            Flexible(child: Text(title, style: const TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }
}
