// ignore_for_file: file_names, deprecated_member_use, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/modules/Agent/Controller/WithdrawalControllerAgent.dart';
import 'package:zayed/modules/Agent/View/widget/WithdrawalWidget/ButtonToggleFlashWidget.dart';
import 'package:zayed/modules/Agent/View/widget/WithdrawalWidget/CameraScanQrWidget.dart';
import 'package:zayed/modules/Agent/View/widget/WithdrawalWidget/EnterCodeManuallyForm.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class WithdrawalScreenAgent extends StatefulWidget {
  const WithdrawalScreenAgent({super.key});

  @override
  State<WithdrawalScreenAgent> createState() => _WithdrawalScreenAgentState();
}

class _WithdrawalScreenAgentState extends State<WithdrawalScreenAgent> {
  late WithdrawalControllerAgent controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(WithdrawalControllerAgent());
  }

  @override
  void dispose() {
    if (Get.isRegistered<WithdrawalControllerAgent>()) {
      Get.delete<WithdrawalControllerAgent>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWidget(
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
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffA90067).withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          AppIcons.notificationsIcon,
                          color: Theme.of(context).primaryColor,
                          width: 20,
                          height: 20,
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
        child: Column(
          children: [
            CameraScanQrWidget(contextMain: context),
            SizedBox(height: 14),
            Center(
              child: Text(
                "وجّه الكاميرا نحو رمز QR لمسحه",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff6A7282),
                  fontSize: 12,
                  fontWeight: MyFontWeight.semiBold,
                ),
              ),
            ),

            SizedBox(height: 14),
            ButtonToggleFlashWidget(),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()),
                  Text(
                    "   او ادخل الرقم التعريفي يدويا    ",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Color(0xff8E939E),
                      fontSize: 12,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
                  Expanded(child: Divider()),
                  SizedBox(height: 14),
                ],
              ),
            ),
            SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ButtonAppWidget(
                primaryButton: false,
                onPressed: () =>
                    showBottomSlideSheet(context, EnterCodeManuallyForm()),
                lable: 'ادخل رمز السحب يدويا',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
