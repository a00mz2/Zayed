import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Influencer/controller/HomeControllerInfluencer.dart';

class CardDepositHistoryWidgetInfluencer extends StatelessWidget {
  CardDepositHistoryWidgetInfluencer({super.key, required this.index});

  final int index;

  final controler = Get.find<HomeControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 68,
      decoration: BoxDecoration(
        color: Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
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
                controler.listHistoryDeposit[index]["relatedAvatar"].toString(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  controler.listHistoryDeposit[index]["relatedName"].toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(0xff312D2C),
                    fontSize: 14,
                    fontWeight: MyFontWeight.regular,
                  ),
                ),
                Text(
                  controler.listHistoryDeposit[index]["notes"].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(0xff4A5565),
                    fontSize: 12,
                    fontWeight: MyFontWeight.light,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                "منذ 9 دقائق",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff828282),
                  fontSize: 11,
                  fontWeight: MyFontWeight.regular,
                ),
              ),
              Text(
                "+ ${formatNumber(controler.listHistoryDeposit[index]["amount"])} د.ع ",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff0AA63E),
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
