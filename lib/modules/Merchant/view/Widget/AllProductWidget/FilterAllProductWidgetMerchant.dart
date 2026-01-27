// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/enum.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Merchant/controller/AllProductControllerMerchant.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class FilterAllProductWidgetMerchant extends StatelessWidget {
  FilterAllProductWidgetMerchant({super.key});

  final controller = Get.find<AllProductControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  "تصفية",
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
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  "السعر",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff3F3F46),
                    fontSize: 14,
                    fontWeight: MyFontWeight.regular,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => SfRangeSliderTheme(
                  data: SfRangeSliderThemeData(
                    activeTrackHeight: 16,
                    inactiveTrackHeight: 16,
                    activeTrackColor: const Color(0xffD1006C),
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbStrokeColor: const Color(0xffD1006C),
                    thumbStrokeWidth: 3,
                    thumbColor: Colors.white,
                    thumbRadius: 13,
                    overlayColor: Colors.transparent,
                    overlayRadius: 0,
                  ),
                  child: SfRangeSlider(
                    min: controller.sliderMin,
                    max: controller.sliderMax,
                    stepSize: 250.0,
                    values: SfRangeValues(
                      controller.minPriceValue.value,
                      controller.maxPriceValue.value,
                    ),
                    enableTooltip: false,
                    onChanged: (SfRangeValues newValues) {
                      controller.minPriceValue.value = roundUp(newValues.start);
                      controller.maxPriceValue.value = roundUp(newValues.end);
                    },
                  ),
                ),
              ),

              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffF4F4F5),
                          ),
                          child: Center(
                            child: Text(
                              "${formatNumber(controller.minPriceValue.value.toInt())} د.ع",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: Color(0xff52525B),
                                    fontSize: 14,
                                    fontWeight: MyFontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 4,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xffE4E4E7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffF4F4F5),
                          ),
                          child: Center(
                            child: Text(
                              "${formatNumber(controller.maxPriceValue.value.toInt())} د.ع",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: Color(0xff52525B),
                                    fontSize: 14,
                                    fontWeight: MyFontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: controller.activeFilter.value,
                      onChanged: (value) => controller.changedActiveFilter(
                        AddToggleType.isActive,
                      ),
                    ),
                  ),
                  Text(
                    "المنتجات المفعلة (فقط)",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff52525B),
                      fontSize: 14,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ],
              ),
              Divider(color: Color(0xffF4F4F5)),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: controller.disabledFilter.value,
                      onChanged: (value) => controller.changedActiveFilter(
                        AddToggleType.disabledFilter,
                      ),
                    ),
                  ),
                  Text(
                    "المنتجات المعطلة (فقط)",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff52525B),
                      fontSize: 14,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ],
              ),
              Divider(color: Color(0xffF4F4F5)),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: controller.isNewArrivalFilter.value,
                      onChanged: (value) => controller.changedActiveFilter(
                        AddToggleType.isNewArrival,
                      ),
                    ),
                  ),
                  Text(
                    "وصل حديثا",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff52525B),
                      fontSize: 14,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ],
              ),
              Divider(color: Color(0xffF4F4F5)),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: controller.isBestSellerFilter.value,
                      onChanged: (value) => controller.changedActiveFilter(
                        AddToggleType.isBestSeller,
                      ),
                    ),
                  ),
                  Text(
                    "الاكثر مبيعا",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff52525B),
                      fontSize: 14,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () => controller.resetFilter(),
                  child: Container(
                    height: 47,
                    width: 114.33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xffF4F4F5)),
                    ),
                    child: Center(
                      child: Text(
                        "إعادة تعيين",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff71717A),
                          fontSize: 16,
                          fontWeight: MyFontWeight.semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                Expanded(
                  child: Obx(
                    () => ButtonAppWidget(
                      statusRequest: controller.statusRequestButton.value,
                      lable: "تصفية",
                      onPressed: () => controller.getProductFilter(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
