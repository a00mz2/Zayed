import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Influencer/controller/HomeControllerInfluencer.dart';
import 'package:zayed/modules/Influencer/view/Widget/HomeWidget/CardDepositHistoryWidgetInfluencer.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class DepositHistoryScreenInfluencer extends StatelessWidget {
  DepositHistoryScreenInfluencer({super.key});

  final controler = Get.find<HomeControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Image.asset(AppIcons.arrowBack, width: 20, height: 20),
          ),
        ),
        title: Text(
          "آخر الاستخدامات",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Color(0xff0E0E0E),
            fontSize: 17,
            fontWeight: MyFontWeight.semiBold,
          ),
        ),
        centerTitle: true,
      ),
      body: ScaffoldWidget(
        onRefresh: () => controler.getDataProfile(),
        appBar: false,
        statusCode: controler.statusCode,
        statusRequest: controler.statusRequest,
        child: Obx(
          () => controler.listHistoryDeposit.isEmpty
              ? SizedBox()
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controler.listHistoryDeposit.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      CardDepositHistoryWidgetInfluencer(index: index),
                ),
        ),
      ),
    );
  }
}
