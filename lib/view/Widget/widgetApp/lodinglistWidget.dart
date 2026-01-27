import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/assets/lottie.dart';

class LodinglistWidget extends StatelessWidget {
  const LodinglistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: 10,
          itemBuilder: (context, index) => ClipRRect(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100000),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Lottie.asset(
                      AppLottie.lodingcover,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 60,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Lottie.asset(
                            AppLottie.lodingcover,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Lottie.asset(
                            AppLottie.lodingcover,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
