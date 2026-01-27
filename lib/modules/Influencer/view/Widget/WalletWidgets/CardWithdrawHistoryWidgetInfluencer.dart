import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/functions/formatDate.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Influencer/controller/WalletControllerInfluencer.dart';

class CardWithdrawHistoryWidgetInfluencer extends StatelessWidget {
  CardWithdrawHistoryWidgetInfluencer({super.key, required this.index});

  final int index;

  final controler = Get.find<WalletControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 68,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color(0xff7B0154), Color.fromARGB(255, 255, 16, 151)],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(1000),
              child: Image.network(
                controler.listHistoryWithdraw[index]["relatedAvatar"]
                    .toString(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, color: Colors.white, size: 30),
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
                          controler.listHistoryWithdraw[index]["title"]
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
                      Flexible(
                        child: Container(
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
                            "${controler.listHistoryWithdraw[index]["relatedName"]}",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Color(0xff231F1E),
                                  fontSize: 10,
                                  fontWeight: MyFontWeight.medium,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "الرصيد بعد العملية ${controler.listHistoryWithdraw[index]["afterBalance"]} د.ع",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(0xff6E615E),
                    fontSize: 12,
                    fontWeight: MyFontWeight.light,
                  ),
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
                "${formatNumber(controler.listHistoryWithdraw[index]["amount"])} د.ع ",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff231F1E),
                  fontSize: 14,
                  fontWeight: MyFontWeight.bold,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                formatDate(controler.listHistoryWithdraw[index]['createdAt']),
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
