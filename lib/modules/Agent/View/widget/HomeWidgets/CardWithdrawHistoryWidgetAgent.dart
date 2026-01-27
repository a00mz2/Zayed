import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatDate.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Agent/Controller/HomeControllerAgent.dart';

class CardWithdrawHistoryWidgetAgent extends StatelessWidget {
  CardWithdrawHistoryWidgetAgent({super.key, required this.index});

  final int index;

  final controller = Get.find<HomeControllerAgent>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 68,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.listHistoryMovements[index]["type"] == "deposit"
                  ? Color(0xffFF2C30).withAlpha(30)
                  : Color(0xff12A150).withAlpha(30),
            ),
            child: Center(
              child: Image.asset(
                controller.listHistoryMovements[index]["type"] == "deposit"
                    ? AppIcons.depositArrow
                    : AppIcons.withdrawArrow,
                width: 20,
                height: 20,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          controller.listHistoryMovements[index]["title"]
                              .toString(),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Color(0xff312D2C),
                                fontSize: 14,
                                fontWeight: MyFontWeight.regular,
                              ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          "${controller.listHistoryMovements[index]["relatedName"]}",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Color(0xff231F1E),
                                fontSize: 10,
                                fontWeight: MyFontWeight.medium,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "الرصيد بعد العملية: ",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Color(0xff6E615E),
                        fontSize: 12,
                        fontWeight: MyFontWeight.light,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        " ${(formatNumber(controller.listHistoryMovements[index]["afterBalance"].abs()))}${controller.listHistoryMovements[index]["afterBalance"] > 0 ? "-" : ""} د.ع",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              controller
                                      .listHistoryMovements[index]["afterBalance"] >
                                  0
                              ? Colors.red
                              : Colors.black,
                          fontSize: 12,
                          fontWeight: MyFontWeight.light,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${formatNumber(controller.listHistoryMovements[index]["amount"])} د.ع ",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff231F1E),
                  fontSize: 14,
                  fontWeight: MyFontWeight.bold,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                formatDate(controller.listHistoryMovements[index]['createdAt']),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff6E615E),
                  fontSize: 12,
                  fontWeight: MyFontWeight.light,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
