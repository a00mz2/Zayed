import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({
    super.key,
    required this.listSliders,
    required this.sliderCurrent,
    Rx<StatusRequest>? statusRequest,
  }) : statusRequest = statusRequest ?? StatusRequest.success.obs;

  final CarouselSliderController slidercontroller = CarouselSliderController();
  final RxList listSliders;
  final RxInt sliderCurrent;

  final Rx<StatusRequest> statusRequest;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => statusRequest.value == StatusRequest.loading
          ? Padding(
              padding: const EdgeInsets.only(top: 15),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  double height = (width) * 168 / 343;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ViewerImageWidget(
                      width: width,
                      height: height,
                      lottieLoding: false,
                    ),
                  );
                },
              ),
            )
          : listSliders.isEmpty
          ? SizedBox()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider.builder(
                  disableGesture: true,
                  carouselController: slidercontroller,
                  itemCount: listSliders.length,
                  itemBuilder: (context, index, realIndex) => LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      double height = (width) * 168 / 343;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: ViewerImageWidget(
                            circular: 12,
                            url: listSliders[index]["image"],
                            width: width,
                            height: height,
                            lodingIcon: SizedBox(),
                          ),
                        ),
                      );
                    },
                  ),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    padEnds: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    pageSnapping: true,
                    height: null,
                    onPageChanged: (index, reason) {
                      sliderCurrent.value = index; // ✅ تحديث المؤشر هنا
                    },
                  ),
                ),

                // 🔘 مؤشرات أسفل السلايدر
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listSliders.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => slidercontroller.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width:
                            6, //sliderCurrent.value == entry.key ? 18.0 : 12.0,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: sliderCurrent.value == entry.key
                              ? Theme.of(context).primaryColor
                              : Color(0xffD5D5D5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
