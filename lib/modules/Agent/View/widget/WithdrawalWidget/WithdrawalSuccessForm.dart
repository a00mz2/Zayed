import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Agent/Controller/WithdrawalControllerAgent.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class WithdrawalSuccessForm extends StatelessWidget {
  WithdrawalSuccessForm({super.key, required this.balance});

  final controller = Get.find<WithdrawalControllerAgent>();

  final int balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Image.asset(AppIcons.Handle, width: 48, height: 6),
          SizedBox(height: 30),
          Image.asset(AppImage.promo, width: 77, height: 77),
          SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            "تم سحب  ${formatNumber(balance)} د.ع  من حساب المستخدم. شكرًا لاستخدامك خدماتنا",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 15,
              fontWeight: MyFontWeight.regular,
              color: Color(0xff2B2B2A),
            ),
          ),
          SizedBox(height: 40),
          ButtonAppWidget(
            onPressed: () => Get.back(),
            lable: "تم",
            icon: Image.asset(AppIcons.checkmark2, width: 20, height: 20),
          ),

          SizedBox(height: 50),
        ],
      ),
    );
  }
}
