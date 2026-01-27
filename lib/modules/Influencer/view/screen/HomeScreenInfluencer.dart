// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/modules/Influencer/controller/HomeControllerInfluencer.dart';
import 'package:zayed/modules/Influencer/view/Widget/HomeWidget/CardDepositHistoryWidgetInfluencer.dart';
import 'package:zayed/modules/Influencer/view/Widget/HomeWidget/headerHomeWidgetInfluencer.dart';
import 'package:zayed/modules/Influencer/view/Widget/HomeWidget/referralCodeFormWidget.dart';
import 'package:zayed/modules/Influencer/view/screen/DepositHistoryScreenInfluencer.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/StatusCard.dart';

class HomeScreenInfluencer extends StatelessWidget {
  HomeScreenInfluencer({super.key});

  final controler = Get.find<HomeControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: false,
      onRefresh: () async => await controler.getDataProfile(),
      statusRequest: controler.statusRequest,
      statusCode: controler.statusCode,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          HeaderHomeWidgetInfluencer(),
          SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      lable: "مرات الاستخدام",
                      value: controler
                          .profileData['stats']['totalSubscriptionsSold']
                          .toString(),
                      icon: AppIcons.peopleIcon,
                    ),
                  ),

                  SizedBox(width: 10),
                  Expanded(
                    child: StatusCard(
                      lable: "الرصيد المتاح ",
                      value:
                          "${formatNumber(controler.profileData['walletBalance'])} د.ع",
                      icon: AppIcons.walt,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 13),

          Obx(
            () => controler.listHistoryDeposit.isEmpty
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(color: Color(0xffE7E4E4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "آخر الاستخدامات",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: Color(0xff0A0A0A),
                                      fontSize: 14,
                                      fontWeight: MyFontWeight.regular,
                                    ),
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.to(DepositHistoryScreenInfluencer()),
                                child: Text(
                                  "عرض الكل",
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff0A0A0A),
                                        fontSize: 12,
                                        fontWeight: MyFontWeight.regular,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => controler.listHistoryDeposit.isEmpty
                                ? SizedBox()
                                : ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controler.listHistoryDeposit.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 10),
                                    itemBuilder: (context, index) =>
                                        CardDepositHistoryWidgetInfluencer(
                                          index: index,
                                        ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffFCF3FB),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.qrcode, width: 50, height: 50),
                  SizedBox(height: 10),
                  Text(
                    "شارك رمز QR الخاص بك ",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Color(0xff0A0A0A),
                      fontSize: 14,
                      fontWeight: MyFontWeight.regular,
                    ),
                  ),
                  Text(
                    "يمكن للمستخدمين مسح الرمز والحصول على الكوبون مباشرة",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Color(0xff575757),
                      fontSize: 12,
                      fontWeight: MyFontWeight.light,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      showBottomSlideSheet(
                        context,
                        referralCodeFormWidget(
                          referralCode: controler.profileData['referralCode'],
                        ),
                        height: Get.size.height - 30,
                      );
                    },
                    child: Container(
                      height: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: [Color(0xdd680039), Color(0xddCE0070)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "عرض رمز QR",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: MyFontWeight.regular,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
