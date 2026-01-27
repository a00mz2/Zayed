import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatDate.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Merchant/view/screen/DetailsInvoiceScreenInMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/PaginationIndicator.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class CardInvoiceWidget extends StatelessWidget {
  const CardInvoiceWidget({
    super.key,
    required this.index,
    required this.dataInvoice,
    this.lengthList,
    this.statusRequestPagination,
  });
  final Map dataInvoice;
  final int? lengthList;
  final Rx<StatusRequest>? statusRequestPagination;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () =>
              Get.to(DetailsInvoiceScreenInMerchant(data: dataInvoice)),
          child: Container(
            margin: EdgeInsets.only(top: index == 0 ? 20 : 0),
            height: 44,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10000),
                  child: Hero(
                    tag: "customerAvatarUrl",
                    child: ViewerImageWidget(
                      errorIcon: Image.asset(
                        AppIcons.registerIcon,
                        width: 25,
                        height: 25,
                        color: Colors.blueGrey.withAlpha(60),
                      ),
                      lodingIcon: Image.asset(
                        AppIcons.registerIcon,
                        width: 25,
                        height: 25,
                        color: Colors.blueGrey.withAlpha(60),
                      ),
                      height: 44,
                      width: 44,
                      url: dataInvoice['customerId']['avatarUrl'],
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "فاتورة رقم ",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Color(0xff231F1E),
                                  fontSize: 14,
                                  fontWeight: MyFontWeight.regular,
                                ),
                          ),
                          Text(
                            "${dataInvoice['invoiceNumber']}#",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Color(0xff231F1E),
                                  fontSize: 14,
                                  fontWeight: MyFontWeight.bold,
                                ),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            formatNumberNum(dataInvoice['finalAmount']),
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Color(0xff231F1E),
                                  fontSize: 14,
                                  fontWeight: MyFontWeight.bold,
                                ),
                          ),
                          Text(
                            " د.ع",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Color(0xff231F1E),
                                  fontSize: 13,
                                  fontWeight: MyFontWeight.regular,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        formatDateWithDayAndTime(dataInvoice['createdAt']),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff6E615E),
                          fontSize: 12,
                          fontWeight: MyFontWeight.light,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        statusRequestPagination == null
            ? SizedBox()
            : Obx(
                () => PaginationIndicator(
                  index: index,
                  listlength: lengthList!,
                  statusRequestPagination: statusRequestPagination!.value,
                ),
              ),

        statusRequestPagination == null
            ? SizedBox()
            : SizedBox(height: index == lengthList! - 1 ? 120 : 0),
      ],
    );
  }
}
