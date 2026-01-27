import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/StaffControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class AddStaffScrrenMerchant extends StatelessWidget {
  AddStaffScrrenMerchant({super.key});

  final controller = Get.find<StaffControllerMerchant>();

  final int? index = Get.arguments != null
      ? Get.arguments['index'] as int
      : null;

  @override
  Widget build(BuildContext context) {
    if (index != null) {
      controller.nameController.text = controller.listStaff[index!]['name'];
      controller.phoneController.text = controller.listStaff[index!]['phone'];
    } else {
      controller.nameController.text = "";
      controller.phoneController.text = "";
      controller.passController.text = "";
    }
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Image.asset(AppIcons.arrowBack, width: 20, height: 20),
          ),
        ),
        centerTitle: true,
        title: Text(
          index != null ? "تعديل الحساب" : "اظافة موضف",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Color(0xff0E0E0E),
            fontSize: 17,
            fontWeight: MyFontWeight.semiBold,
          ),
        ),
      ),

      body: Form(
        key: controller.formstate.value,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 25),
            Text(
              "اسم الموظف",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff51515A),
                fontSize: 13,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            SizedBox(height: 5),
            TextBoxDark(
              controller: controller.nameController,
              hintText: "ادخل اسم الموظف",
            ),
            SizedBox(height: 15),

            Text(
              "رقم الهاتف",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff51515A),
                fontSize: 13,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            SizedBox(height: 5),
            TextBoxDark(
              readOnly: index != null ? true : false,
              controller: controller.phoneController,
              typeVal: "phone",
              maxLength: 11,
              maxLines: 11,
              minLength: 11,
              type: TextInputType.number,
              hintText: "رقم هاتف واتساب",
              suffixIcon: Text(
                "العراق (+964)",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: MyFontWeight.regular,
                  color: Color(0xff747474),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "كلمة المرور",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff51515A),
                fontSize: 13,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            SizedBox(height: 5),
            Obx(
              () => TextBoxDark(
                controller: controller.passController,
                obscureText: controller.obscureText.value,
                showPassword: () => controller.showPassword(),
                hintText: "كلمة المرور",
              ),
            ),
            SizedBox(height: 30),
            Obx(
              () => ButtonAppWidget(
                onPressed: () => index == null
                    ? controller.createStaff()
                    : controller.updateStaff(
                        controller.listStaff[index!]["_id"],
                      ),
                statusRequest: controller.statusRequestButton.value,
                lable: "حفظ",
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
