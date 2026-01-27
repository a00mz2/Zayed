// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/images.dart';

class OtpScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  OtpScreen({super.key});
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    String type = args != null ? args['type'] : 'register';

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Image.asset(
            AppImage.backgrond1,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      controller.statusRequest.value = StatusRequest.success;
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "تأكيد رقم الهاتف",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: MyFontWeight.semiBold,
                    color: Color(0xff0E0E0E),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "ادخل الكود المرسل إلى حساب الواتساب الخاص ب",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: MyFontWeight.regular,
                    color: Color(0xff5A5A5A),
                  ),
                ),

                SizedBox(height: 8),
                Text(
                  "${controller.phoneNumber} (+964)",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: MyFontWeight.semiBold,
                    color: Color(0xff0E0E0E),
                  ),
                ),
                SizedBox(height: 32),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPTextField(
                    keyboardType: TextInputType.number,
                    otpFieldStyle: OtpFieldStyle(),
                    controller: controller
                        .otpFieldController, // 👈 الربط مع الـ Controller
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 40,
                    style: const TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: (pin) {
                      controller.otpCode.value = pin;
                    },
                    onCompleted: (pin) {
                      controller.otpCode.value = pin;
                      controller.verifyCode(type);
                    },
                  ),
                ),

                const SizedBox(height: 12),

                Obx(
                  () => controller.enableResend.value
                      ? TextButton(
                          onPressed: controller.resendCode,
                          child: const Text(
                            "إعادة إرسال الرمز",
                            style: TextStyle(
                              color: Color(0xFF4A2E1F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          "يمكنك إعادة إرسال الرمز خلال 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
