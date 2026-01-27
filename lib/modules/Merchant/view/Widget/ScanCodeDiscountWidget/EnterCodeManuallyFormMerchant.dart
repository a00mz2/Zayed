import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/ScanCodeDiscountControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class EnterCodeManuallyFormMerchant extends StatelessWidget {
  EnterCodeManuallyFormMerchant({super.key, this.titleEror});

  final controller = Get.find<ScanCodeDiscountControllerMerchant>();
  final String? titleEror;

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
                "كود الخصم",
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
                  controller: controller.discountCodeController,
                  hintText: "ادخل كود الخصم للمستخدم ...",
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: Color(0xff6A7282),
                  ),
                ),
              ),
              titleEror == null
                  ? SizedBox()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 14),
                        Text(
                          titleEror!,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 12, color: Colors.red),
                        ),
                      ],
                    ),

              const SizedBox(height: 14),
              Obx(
                () => ButtonAppWidget(
                  statusRequest: controller.statusRequest.value,
                  onPressed: () => controller.verifyInvoice(
                    controller.discountCodeController.text,
                    context,
                    isValidate: true,
                  ),
                  lable: 'تحقق',
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
