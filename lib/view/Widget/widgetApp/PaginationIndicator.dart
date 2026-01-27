import 'package:flutter/material.dart';
import 'package:zayed/core/class/statusRequest.dart';

class PaginationIndicator extends StatelessWidget {
  const PaginationIndicator({
    super.key,
    required this.index,
    required this.listlength,
    required this.statusRequestPagination,
  });

  final int index, listlength;
  final StatusRequest statusRequestPagination;

  @override
  Widget build(BuildContext context) {
    return index == listlength - 1
        ? Container(
            margin: EdgeInsets.only(top: 30),
            height: 5,
            child: statusRequestPagination == StatusRequest.loading
                ? Center(
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : const SizedBox(),
          )
        : const SizedBox();
  }
}
