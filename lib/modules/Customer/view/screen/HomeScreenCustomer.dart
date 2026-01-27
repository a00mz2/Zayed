// ignore_for_file: file_names, must_be_immutable, unrelated_type_equality_checks

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/modules/Customer/Controller/HomeControllerCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/AppbarWidgetCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/DiscountGroupWidgetCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/GridFeaturedStoreWidget.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/ListsSelectedItemWidgetCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/ListStoreTypeWidgetCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/SearchFieldCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/SliderWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class HomeScreenCustomer extends StatelessWidget {
  final HomeControllerCustomer controller = Get.put(HomeControllerCustomer());

  HomeScreenCustomer({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      onRefresh: () => controller.getDataHome(),
      statusRequest: controller.statusRequest,
      statusCode: controller.statusCode,

      child: Stack(
        children: [
          Obx(() {
            final isLoading =
                controller.statusRequestGradient.value ==
                StatusRequest.loading;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              opacity: isLoading ? 0.0 : 1.0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
                offset: isLoading ? const Offset(0, 0.05) : Offset.zero,
                child: Container(
                  width: double.infinity,
                  height: 269,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffFFCCEA), Color(0xffFFFFFF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            );
          }),
          ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              AppbarWidgetCustomer(
                statusRequest: controller.statusRequestdataAccount,
                dataAccount: controller.dataAccount,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SearchFieldCustomer(),
              ),
              SliderWidget(
                statusRequest: controller.statusRequestSliders,
                listSliders: controller.listSliders,
                sliderCurrent: controller.sliderCurrent,
              ),
              SizedBox(height: 8),
              GridFeaturedStoreWidget(
                circleButtonShowAllStore: true,
                statusRequest: controller.statusRequestMerchant,
                listMerchant: controller.listMerchant,
              ),
              StoresTypeWidgetCustomer(
                statusRequest: controller.statusRequestStoreType,
                listStoresType: controller.listStoreType,
              ),
              SizedBox(height: 8),

              DiscountGroupWidgetCustomer(
                statusRequest: controller.statusRequestDiscountGroup,
                listDiscountGroup: controller.listDiscountGroup,
              ),

               ListsSelectedItemWidgetCustomer(
                statusRequest: controller.statusRequestStoresByCatigory,
                listStoresByCatigory: controller.listStoresByCatigory,
              ),
              SizedBox(height: 100),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).viewPadding.top,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.00), // لمسة ضباب
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
