import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/modules/Merchant/controller/HomeControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/MainControllerMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/AppbarWidgetMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/HomeWidget/HomeLodingMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/HomeWidget/SalesGrowthChartMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/InvoiceWidget/CardInvoiceWidget.dart';
import 'package:zayed/modules/Merchant/view/Widget/ProductWidgetMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/StatusCard.dart';

class HomeScrrenMerchant extends StatelessWidget {
  HomeScrrenMerchant({super.key});

  final controller = Get.find<HomeControllerMerchant>();
  final controllerMain = Get.find<MainControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWidget(
        lodingWidget: HomeLodingMerchant(),
        statusCode: controller.statusCode,
        statusRequest: controller.statusRequest,
        onRefresh: () => controller.getDataHome(),

        heder: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppbarWidgetMerchant(),
        ),
        child: Obx(
          () => ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: StatusCard(
                        lable: "اجمالي المنتجلت",
                        value: controller.summary.isNotEmpty
                            ? controller.summary['totalProducts']
                            : null,
                        icon: AppIcons.Product,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatusCard(
                        lable: "اجمالي الفواتير",
                        value: controller.summary['totalInvoices'],
                        icon: AppIcons.registerIcon,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StatusCard(
                  lable: "اجمالي المبيعات",
                  icon: AppIcons.money2,
                  value:
                      "${formatNumberNum(controller.summary['totalProfit'])} د.ع",
                ),
              ),

              SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 236,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffE7E4E4)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "معدل نمو المبيعات",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff292929),
                          fontSize: 14,
                          fontWeight: MyFontWeight.semiBold,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ScrollableSalesChart(
                          growthData: controller.growthChart.reversed.toList(),
                        ),
                      ),
                    ],
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
                      onTap: () => Get.toNamed('/merchant/category'),
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
              controller.categories.isEmpty
                  ? NoDataAvailableWidget(
                      physics: NeverScrollableScrollPhysics(),
                      assets: Lottie.asset(
                        AppLottie.empty,
                        width: 150,
                        height: 150,
                      ),
                      title: 'لا توجد أقسام بعد',
                      bodyText: 'ابدأ بإنشاء قسم جديد لتنظيم منتجاتك بشكل أفضل',
                      onPressed: () => Get.toNamed("/merchant/addCategory"),
                      buttonLable: "انشاء قسم جديد",
                    )
                  : SizedBox(
                      height: 32,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 4),
                        itemCount: controller.categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(
                            right: index == 0 ? 16 : 0,
                            left: index == controller.categories.length - 1
                                ? 16
                                : 0,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10000),

                            onTap: () => Get.toNamed(
                              '/merchant/SubCategory',
                              arguments: {
                                'categoryId':
                                    controller.categories[index]['_id'],
                                "categoryName":
                                    controller.categories[index]['name'],
                              },
                            ),
                            child: Container(
                              height: 32,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffF6F6F6),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                controller.categories[index]['name'],
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Color(0xff747474),
                                      fontSize: 12,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                              ),
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
                      onTap: () => controllerMain.changeTab(3),
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
              controller.latestProducts.isEmpty
                  ? SizedBox(
                      child: NoDataAvailableWidget(
                        physics: NeverScrollableScrollPhysics(),
                        assets: Lottie.asset(
                          AppLottie.emptyBox,
                          width: 150,
                          height: 150,
                        ),
                        title: 'لا توجد منتجات بعد',
                        bodyText: 'ابدأ بإضافة منتج جديد لعرضه للعملاء',
                        onPressed: () => Get.toNamed("/merchant/addProductAll"),
                        buttonLable: "اضافة منتج جديد",
                      ),
                    )
                  : SizedBox(
                      height: 239,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.latestProducts.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(
                            right: index == 0 ? 16 : 0,
                            left: index == controller.latestProducts.length - 1
                                ? 16
                                : 0,
                          ),

                          width: 161.5,
                          height: 239,

                          child: InkWell(
                            onTap: () => Get.toNamed(
                              "/merchant/addProductAll",
                              arguments: {'index': index},
                            ),
                            child: ProductWidgetMerchant(
                              productData: controller.latestProducts[index],
                              maxAmount: controller.maxAmount.value,
                              percent: controller.percent.value,
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
                      "احدث  الفواتير",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff0E0E0E),
                        fontSize: 16,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => controllerMain.changeTab(1),
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
              controller.latestInvoices.isEmpty
                  ? NoDataAvailableWidget(
                      assets: Lottie.asset(
                        AppLottie.BillsEmpty,
                        width: 150,
                        height: 150,
                      ),
                      title: 'لا توجد فواتير بعد',
                      bodyText: 'ستضهر احدث الفواتير هنا بعد انشائها',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.latestInvoices.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 20, color: Color(0xffF3F2F1)),
                      itemBuilder: (context, index) => CardInvoiceWidget(
                        index: index,
                        dataInvoice: controller.latestInvoices[index],
                        lengthList: controller.latestInvoices.length,
                      ),
                    ),

              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
