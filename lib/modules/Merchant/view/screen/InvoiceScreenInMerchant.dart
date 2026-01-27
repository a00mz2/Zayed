// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Merchant/controller/InvoiceControllerMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/AppbarWidgetMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/InvoiceWidget/CardInvoiceWidget.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchNoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/StatusCard.dart';
import 'package:zayed/view/Widget/widgetApp/lodinglistWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class InvoiceScreenInMerchant extends StatelessWidget {
  InvoiceScreenInMerchant({super.key});

  final controller = Get.find<InvoiceControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWidget(
        lodingWidget: LodinglistWidget(),
        horizontalPadding: 16,
        appBar: false,
        onRefresh: () => controller.getInvoice(),
        statusRequest: controller.statusRequest,
        statusCode: controller.statusCode,
        heder: Column(
          children: [
            AppbarWidgetMerchant(),
            SizedBox(height: 7),
            Obx(
              () => controller.totalInvoice.value == null
                  ? ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Lottie.asset(
                        AppLottie.lodingImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 90,
                      ),
                    )
                  : StatusCard(
                      lable: "اجمالي الفواتير",
                      value: formatNumber(controller.totalInvoice.value!),
                      icon: AppIcons.registerIcon,
                    ),
            ),

            Obx(
              () =>
                  controller.listInvoice.isEmpty &&
                      controller.searchController.text.toString().isEmpty
                  ? SizedBox()
                  : Column(
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          child: TextBoxDark(
                            hintText: " البحث في الفواتير... ",
                            controller: controller.searchController,
                            onChanged: (p0) => controller.search(),
                            prefixIcon: Image.asset(
                              AppIcons.research,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Obx(
            () => controller.listInvoice.isEmpty
                ? controller.searchController.text.toString().isNotEmpty
                      ? SearchNoDataAvailableWidget(
                          onPressed: () {
                            controller.searchController.text = "";
                            controller.getInvoice();
                          },
                        )
                      : NoDataAvailableWidget(
                          assets: Lottie.asset(
                            AppLottie.BillsEmpty,
                            width: 150,
                            height: 150,
                          ),
                          title: 'لا توجد فواتير بعد',
                          bodyText: 'ستضهر الفواتير هنا بعد انشائها',
                        )
                : ListView.separated(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: controller.listInvoice.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 20, color: Color(0xffF3F2F1)),
                    itemBuilder: (context, index) => CardInvoiceWidget(
                      index: index,
                      dataInvoice: controller.listInvoice[index],
                      lengthList: controller.listInvoice.length,
                      statusRequestPagination:
                          controller.statusRequestPagination,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
