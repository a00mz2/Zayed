// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/NotificationsController.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Agent/Controller/HomeControllerAgent.dart';
import 'package:zayed/modules/Agent/Controller/MainControlIerAgent.dart';
import 'package:zayed/modules/Agent/View/widget/HomeWidgets/CardWithdrawHistoryWidgetAgent.dart';
import 'package:zayed/view/Widget/widgetApp/PaginationIndicator.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/StatusCard.dart';

class HomeScreenAgent extends StatelessWidget {
  HomeScreenAgent({super.key});

  final controller = Get.find<HomeControllerAgent>();
  final mainController = Get.find<MainControllerAgent>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWidget(
        appBar: false,
        onRefresh: () => controller.getDataWallet(),
        statusCode: controller.statusCode,
        statusRequest: controller.statusRequest,
        heder: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 56,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppImage.logo,
                      color: Theme.of(context).primaryColor,
                      width: 28,
                      height: 36,
                    ),

                    Obx(
                      () => InkWell(
                        borderRadius: BorderRadius.circular(10000),
                        onTap: () => Get.toNamed("/Notifications"),
                        child: unreadCount.value == 0
                            ? Image.asset(
                                AppIcons.notifications,
                                width: 40,
                                height: 40,
                              )
                            : Image.asset(
                                AppIcons.notificationsAc,
                                width: 40,
                                height: 40,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              controller: controller.scrollController,
              children: [
                SizedBox(
                  height: 100,
                  child: StatusCard(
                    valueColor: controller.balance.value > 0
                        ? Colors.red
                        : Color(0xff231F1E),
                    lable: controller.balance.value > 0
                        ? "الرصيد المستحق"
                        : "الرصيد المتوفر",
                    value:
                        "${formatNumber(controller.balance.value.abs())} ${controller.balance.value > 0 ? "-" : ""} د.ع",

                    horizontaPadding: 16,
                    verticalPadding: 16,
                    icon: AppIcons.money,
                    fontSizeValue: 25,
                    fontWeightValue: MyFontWeight.medium,
                    fontSizeLable: 16,
                  ),
                ),
                SizedBox(height: 18),
                ListView.separated(
                  itemCount: controller.listHistoryMovements.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      Divider(color: Color(0xffF3F2F1), height: 4),
                  itemBuilder: (context, index) => Column(
                    children: [
                      CardWithdrawHistoryWidgetAgent(index: index),
                      Obx(
                        () => PaginationIndicator(
                          index: index,
                          listlength: controller.listHistoryMovements.length,
                          statusRequestPagination:
                              controller.statusRequestPagination.value,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
