// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBox.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.formstate,
    required this.oldPassController,
    required this.newPassController,
    this.onPressed,
    required this.obscureText1,
    required this.obscureText2,
    this.showPassword,
    required this.statusRequest,
  });

  final Rx<GlobalKey<FormState>> formstate;

  final TextEditingController oldPassController, newPassController;

  final RxBool obscureText1, obscureText2;

  final dynamic Function()? onPressed;
  final dynamic Function(bool obscure)? showPassword;
  final Rx<StatusRequest> statusRequest;

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
          "تغيير كلمة المرور",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Color(0xff0E0E0E),
            fontSize: 17,
            fontWeight: MyFontWeight.semiBold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Form(
          key: formstate.value,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),

            children: [
              SizedBox(height: 45),
              TextBoxs(
                controller: oldPassController,
                obscureText: obscureText1.value,
                showPassword: () => showPassword!(true),
                hintText: "كلمة المرور الحالية",
              ),
              SizedBox(height: 16),
              TextBoxs(
                controller: newPassController,
                obscureText: obscureText2.value,
                showPassword: () => showPassword!(false),
                hintText: "كلمة المرور الجديدة",
              ),
              SizedBox(height: 32),
              Obx(
                () => ButtonAppWidget(
                  radius: 12,
                  statusRequest: statusRequest.value,
                  onPressed: onPressed,
                  lable: "حفظ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
