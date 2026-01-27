import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';

class HomeLodingMerchant extends StatelessWidget {
  const HomeLodingMerchant({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Lottie.asset(
                      AppLottie.lodingcover,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 90,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Lottie.asset(
                      AppLottie.lodingcover,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 90,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Lottie.asset(
                AppLottie.lodingcover,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 90,
              ),
            ),
          ),

          SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Lottie.asset(
                AppLottie.lodingcover,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 236,
              ),
            ),
          ),
          SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "الاصناف الرئيسية",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff0E0E0E),
                    fontSize: 16,
                    fontWeight: MyFontWeight.medium,
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "المزيد",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xffCE0070),
                      fontSize: 12,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ),
                Image.asset(
                  AppIcons.arrowGo,
                  width: 16,
                  height: 16,
                  color: Color(0xffCE0070),
                ),
              ],
            ),
          ),

          SizedBox(height: 14),

          SizedBox(
            height: 32,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 4),
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(right: index == 0 ? 16 : 0),

                width: 90,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  child: Lottie.asset(
                    AppLottie.lodingcover,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 32,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "المنتجات",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff0E0E0E),
                    fontSize: 16,
                    fontWeight: MyFontWeight.medium,
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "المزيد",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xffCE0070),
                      fontSize: 12,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ),
                Image.asset(
                  AppIcons.arrowGo,
                  width: 16,
                  height: 16,
                  color: Color(0xffCE0070),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          SizedBox(
            height: 239,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemBuilder: (context, index) => SizedBox(
                width: 161.5,
                height: 239,

                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: index == 0 ? 16 : 0),

                        width: 162,
                        height: 162,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(16),
                          child: Lottie.asset(
                            AppLottie.lodingcover,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 32,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: 150,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(16),
                          child: Lottie.asset(
                            AppLottie.lodingcover,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 32,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 90,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(16),
                          child: Lottie.asset(
                            AppLottie.lodingcover,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 100),
        ],
      ),
    );
  }
}
