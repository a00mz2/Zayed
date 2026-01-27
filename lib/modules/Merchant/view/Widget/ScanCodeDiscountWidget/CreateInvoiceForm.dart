import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/modules/Merchant/controller/ScanCodeDiscountControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class CreateInvoiceForm extends StatelessWidget {
  CreateInvoiceForm({
    super.key,
    required this.code,
    this.title = "تم التحقق من رمز العرض بنجاح",
  });

  final controller = Get.find<ScanCodeDiscountControllerMerchant>();
  final String code;
  final String? title;

  @override
  Widget build(BuildContext context) {
    // 1. حساب ارتفاع لوحة المفاتيح
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // مقبض السحب (Handle)
            SizedBox(
              height: 40,
              child: Center(
                child: Image.asset(AppIcons.Handle, width: 48, height: 6),
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Image.asset(AppImage.DiscountCircle, width: 64, height: 64),
                    const SizedBox(height: 16),
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xff434343),
                        fontSize: 20,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "حدد قيمة الفاتورة ليتم تطبيق العرض على المبلغ الكلي 💸",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xff8C8C8C),
                        fontSize: 14,
                        fontWeight: MyFontWeight.light,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: controller.formstate.value,
                            child: TextBoxDark(
                              controller: controller.priceController,
                              onChanged: (p0) => controller.calculatePrice(),
                              hintText: "المبلغ",
                              type: TextInputType.number,
                              prefixIcon: Image.asset(
                                AppIcons.dollar,
                                width: 20,
                                height: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextBoxDark(
                            readOnly: true,
                            controller: controller.priceAfterDiscountController,
                            hintText: "المبلغ بعد الخصم",
                            type: TextInputType.number,
                            prefixIcon: Image.asset(
                              AppIcons.percentage,
                              width: 20,
                              height: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 20,
                top: 10,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: ButtonAppWidget(
                      elevation: 0,
                      color: const Color(0xffF3F3F5),
                      lable: "الغاء",
                      textColor: const Color(0xff727272),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ButtonAppWidget(
                      lable: "اتمام",
                      onPressed: () => controller.createInvoice(code),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
