import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class SearchFilterOrderWidget extends StatelessWidget {
  SearchFilterOrderWidget({
    super.key,
    RxBool? orderMode,
    RxBool? showFilter,
    RxBool? filterMode,
    this.orderFunction,
    this.controllerTextBox,
    this.onSearch,
    this.filterFunction,
    this.lable = "بحث ...",
  }) : orderMode = orderMode ?? false.obs,
       showFilter = showFilter ?? true.obs,
       filterMode = filterMode ?? false.obs;

  final RxBool orderMode;
  final RxBool showFilter;
  final RxBool filterMode;
  final String? lable;

  final Function()? orderFunction;
  final Function()? filterFunction;
  final Function(String)? onSearch;
  final TextEditingController? controllerTextBox;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextBoxDark(
              onChanged: onSearch,
              controller: controllerTextBox,
              hintText: lable,
              prefixIcon: Image.asset(AppIcons.research, width: 20, height: 20),
            ),
          ),
        ),
        SizedBox(width: showFilter.value ? 8 : 0),

        /// filter
        showFilter.value
            ? Obx(
                () => showFilter.value
                    ? InkWell(
                        onTap: filterFunction ?? () {},
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: filterMode.value
                                ? Theme.of(context).primaryColor
                                : const Color(0xffF6F6F6),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppIcons.filter,
                              color: filterMode.value ? Colors.white : null,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            : SizedBox(),

        const SizedBox(width: 8),

        /// order
        Obx(
          () => BouncingWidget(
            duration: const Duration(milliseconds: 80),
            scaleFactor: 1,
            onPressed: orderFunction ?? () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: orderMode.value
                    ? Theme.of(context).primaryColor
                    : const Color(0xffF6F6F6),
              ),
              child: Center(
                child: Image.asset(
                  AppIcons.order,
                  width: 20,
                  height: 20,
                  color: !orderMode.value
                      ? const Color(0xff0E0E0E)
                      : const Color(0xffF6F6F6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
