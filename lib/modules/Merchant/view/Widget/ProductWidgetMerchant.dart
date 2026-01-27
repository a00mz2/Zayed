import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/lottie.dart';

class ProductWidgetMerchant extends StatelessWidget {
  const ProductWidgetMerchant({
    super.key,
    required this.productData,
    required this.maxAmount,
    required this.percent,
  });

  final Map productData;

  final num maxAmount;
  final int percent;

  String getProductImage() {
    final images = productData['images'];
    if (images is List && images.isNotEmpty) {
      return images.first['url']?.toString() ?? "";
    }
    return "";
  }

  double calculatePriceAfterDiscount({required int price}) {
    double discountValue = price * (percent / 100);
    if (maxAmount > 0 && discountValue > maxAmount) {
      discountValue = maxAmount.toDouble();
    }
    double finalPrice = price - discountValue;
    if (finalPrice < 0) finalPrice = 0;
    return finalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: productImage(getProductImage(), size, size),
                ),
                productData['isActive']
                    ? SizedBox()
                    : Positioned(
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "معطل",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: MyFontWeight.regular,
                                ),
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 4),
            Flexible(
              child: SizedBox(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  productData['name'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff5A5A5A),
                    fontSize: 12,
                    fontWeight: MyFontWeight.regular,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    "${calculatePriceAfterDiscount(price: productData['price'])} د.ع",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xff0E0E0E),
                      fontSize: 12,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget productImage(String? url, width, height) {
    if (url == null || url.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey.withAlpha(30),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.broken_image_rounded,
          color: Colors.blueGrey,
          size: 25,
        ),
      );
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Lottie.asset(
                AppLottie.lodingImage,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
              Center(
                child: Icon(
                  Icons.image,
                  color: Colors.blueGrey.withAlpha(20),
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.blueGrey.withAlpha(30),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.broken_image_rounded,
            color: Colors.blueGrey,
            size: 25,
          ),
        );
      },
    );
  }
}
