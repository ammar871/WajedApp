import 'package:flutter/material.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';




extension APIImage on BuildContext {
  String getImageURL(String? image) {
    if (image != null) {
      return ApiConstants.baseUrlImages+image;
    } else {
      return "";
    }
  }
}

extension Direction on BuildContext {
  bool isRTL() =>
      dependOnInheritedWidgetOfExactType<Directionality>()!.textDirection ==
              TextDirection.rtl
          ? true
          : false;

  TextDirection direction() =>
      dependOnInheritedWidgetOfExactType<Directionality>()!.textDirection;
}







