// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/modules/Influencer/controller/WalletControllerInfluencer.dart';
import 'package:zayed/modules/Influencer/view/Widget/WalletWidgets/CardWithdrawHistoryWidgetInfluencer.dart';
import 'package:zayed/modules/Influencer/view/Widget/WalletWidgets/HeaderWalletWidgetInfluencer.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class WalletScreenInfluencer extends StatelessWidget {
  WalletScreenInfluencer({super.key});

  final controler = Get.find<WalletControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      onRefresh: () => controler.getDataProfile(),
      statusRequest: controler.statusRequest,
      statusCode: controler.statusCode,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          HeaderWalletWidgetInfluencer(),
          SizedBox(height: 13),
          InkWell(
            onTap: () => controler.withdrawalRequest(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Color(0xdd680039), Color(0xddCE0070)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
              child: Center(
                child: Text(
                  "طلب سحب جديد",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: MyFontWeight.regular,
                  ),
                ),
              ),
            ),
          ),

          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: controler.listHistoryWithdraw.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    Divider(color: Color(0xffF3F2F1), height: 4),
                itemBuilder: (context, index) =>
                    CardWithdrawHistoryWidgetInfluencer(index: index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
