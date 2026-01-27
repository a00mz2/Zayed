import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/modules/Customer/Controller/StoreMainCategoriesControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class StoreMainCategoriesScrrenCustomer extends StatelessWidget {
    StoreMainCategoriesScrrenCustomer({super.key});

final StoreMainCategoriesControllerCustomer controller = Get.find<StoreMainCategoriesControllerCustomer>(); 

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      namePage: "",
    );
  }
}

