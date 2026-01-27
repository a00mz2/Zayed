// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/StaffControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/CategoryActionsMenu.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class StaffScrrenMerchant extends StatelessWidget {
  StaffScrrenMerchant({super.key});

  final controller = Get.find<StaffControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      onRefresh: () => controller.getStaff(),
      namePage: "الموضفين",
      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      appBar: true,
      bottomNavigationBar: Obx(
        () => controller.listStaff.isEmpty
            ? SizedBox()
            : Container(
                height: 72,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ButtonAppWidget(
                  statusRequest: controller.statusRequestButton.value,
                  lable: "اضافة موظف",
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () => Get.toNamed("/merchant/addStaff"),
                ),
              ),
      ),
      child: Obx(
        () => controller.listStaff.isEmpty
            ? NoDataAvailableWidget(
                assets: Lottie.asset(
                  AppLottie.emptyBox,
                  width: 150,
                  height: 150,
                ),
                title: 'ليس لديك اي موضفين',
                bodyText: 'يمكنك اضافة موضفين الى متجرك',
                onPressed: () => Get.toNamed("/merchant/addStaff"),
                buttonLable: "اضافة",
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.listStaff.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: index == 0 ? 20 : 0),
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppIcons.avatar, width: 36, height: 36),
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          controller.listStaff[index]['name'],
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Color(0xff71717A),
                                fontSize: 16,
                                fontWeight: MyFontWeight.regular,
                              ),
                        ),
                      ),

                      Expanded(child: SizedBox()),
                      Obx(
                        () => controller.indexDeleted.value == index
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Lottie.asset(AppLottie.deleteLoding),
                              )
                            : CategoryActionsMenu(
                                items: [
                                  ActionMenuItem(
                                    label: 'تعديل',
                                    iconPath: AppIcons.edit,
                                    onTap: () {
                                      Get.toNamed(
                                        '/merchant/addStaff',
                                        arguments: {'index': index},
                                      );
                                    },
                                  ),
                                  ActionMenuItem(
                                    label: 'حذف',
                                    iconPath: AppIcons.remove,
                                    color: Colors.red,
                                    onTap: () => controller.deleteStaff(index),
                                  ),
                                ],
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
