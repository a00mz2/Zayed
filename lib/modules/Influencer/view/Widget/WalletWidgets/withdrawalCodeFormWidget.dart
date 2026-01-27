// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/BordersDotted.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatNumber.dart';

class withdrawalCodeFormWidget extends StatelessWidget {
  const withdrawalCodeFormWidget({
    super.key,
    required this.statusRequest,
    required this.codeWithdrawalRequest,
    required this.balanceWallet,
    required this.avatarUrl,
    required this.name,
  });

  final Rx<StatusRequest> statusRequest;
  final RxString codeWithdrawalRequest;
  final int balanceWallet;
  final String avatarUrl, name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: InkWell(
                onTap: () => Get.back(),
                child: Row(children: [Icon(Icons.close)]),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Obx(
              () => statusRequest.value != StatusRequest.success
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "طلب سحب جديد",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 20,
                                  fontWeight: MyFontWeight.semiBold,
                                ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "قدم الرمز للمسؤول في المتجر لإتمام العملية",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Color(0xff747474),
                                  fontSize: 14,
                                  fontWeight: MyFontWeight.regular,
                                ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 290,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(30),

                                blurRadius: 8,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 162,
                                height: 162,
                                child: Obx(
                                  () => PrettyQrView.data(
                                    data: codeWithdrawalRequest.value,
                                    decoration: const PrettyQrDecoration(
                                      shape: PrettyQrShape.custom(
                                        PrettyQrSquaresSymbol(),
                                        finderPattern: PrettyQrSquaresSymbol(),
                                        alignmentPatterns:
                                            PrettyQrSmoothSymbol(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                codeWithdrawalRequest.value.toString(),
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: Color(0xff51515A),
                                      fontSize: 20,
                                      fontWeight: MyFontWeight.light,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CustomPaint(
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
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10000),
                                      child: Image.network(
                                        avatarUrl,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                  AppIcons.userCircle,
                                                ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  Text(
                                    name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
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
                                      "${formatNumber(balanceWallet)}د.ع",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
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
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
