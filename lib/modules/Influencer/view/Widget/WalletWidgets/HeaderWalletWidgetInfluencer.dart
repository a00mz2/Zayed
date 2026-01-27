// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Influencer/controller/WalletControllerInfluencer.dart';

class HeaderWalletWidgetInfluencer extends StatelessWidget {
  HeaderWalletWidgetInfluencer({super.key});

  final controler = Get.find<WalletControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 224,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff770053), Color(0xffB9006D), Color(0xffCE0070)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 77),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                height: 86,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withAlpha(50),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppIcons.walt, width: 18),
                        SizedBox(width: 5),
                        Text(
                          "الرصيد المتاح",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: MyFontWeight.light,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${formatNumber(controler.balanceWallet.value)} د.ع",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "اجمالي الارباح",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: MyFontWeight.light,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${formatNumber(controler.profileData['stats']['totalEarnings'])} د.ع",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
