import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:zayed/core/class/BordersDotted.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Agent/Controller/WithdrawalControllerAgent.dart';

class WithdrawalOtpForm extends StatelessWidget {
  WithdrawalOtpForm({
    super.key,
    required this.phoneNumber,
    required this.balance,
    this.avatarUrl,
    required this.name,
    required this.code,
  });

  final controller = Get.find<WithdrawalControllerAgent>();

  final String phoneNumber, name, code;
  final int balance;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        SizedBox(height: 20),
        Image.asset(AppIcons.Handle, width: 48, height: 6),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تاكيد عملية السحب",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: MyFontWeight.semiBold,
                  color: Color(0xff0E0E0E),
                ),
              ),
              SizedBox(height: 32),
              Text(
                textAlign: TextAlign.center,
                "تم ارسال كود تحقق الى حساب العميل على الواتساب  ادخل الكود المكون من 6 ارقام لاتمام عملية السحب",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: MyFontWeight.regular,
                  color: Color(0xff5A5A5A),
                ),
              ),

              SizedBox(height: 8),
              Text(
                "$phoneNumber (+964)",
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
                    controller.confirmCode(code, pin);
                  },
                ),
              ),

              SizedBox(height: 32),

              CustomPaint(
                painter: BordersDotted(),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10000),
                          child: Image.network(
                            avatarUrl ?? "",
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AppIcons.userCircle),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(0xff0E0E0E),
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                        ),
                      ),
                      Expanded(child: SizedBox.shrink()),
                      Container(
                        alignment: Alignment.center,
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff770053),
                              Color(0xffCE0070),
                              Color(0xff770053),
                            ],
                          ),
                        ),
                        child: Text(
                          "${formatNumber(balance)}د.ع",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
