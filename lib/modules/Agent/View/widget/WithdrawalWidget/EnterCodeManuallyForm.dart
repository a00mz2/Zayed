import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Agent/Controller/WithdrawalControllerAgent.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class EnterCodeManuallyForm extends StatelessWidget {
  EnterCodeManuallyForm({super.key});

  final controller = Get.find<WithdrawalControllerAgent>();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 0),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: bottomInset,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "الرقم التعريفي للمستخدم",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: const Color(0xff51515A),
                  fontSize: 13,
                  fontWeight: MyFontWeight.semiBold,
                ),
              ),
              const SizedBox(height: 5),
              Form(
                key: controller.formstate.value,
                child: TextBoxDark(
                  controller: controller.codWithdrawalController,
                  hintText: "ادخل رمز السحب للمستخدم ...",
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: Color(0xff6A7282),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Obx(
                () => ButtonAppWidget(
                  statusRequest: controller.statusRequest.value,
                  onPressed: () => controller.submitCode(
                    controller.codWithdrawalController.text,
                    context,
                    isValidate: true,
                  ),
                  lable: 'سحب المبلغ',
                  icon: Image.asset(AppIcons.checkmark2, width: 20, height: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
