import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wajed_app/common/order/data/models/order_status_model.dart';
import 'package:wajed_app/core/utils/api_constatns.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../utils/app_model.dart';

extension AppExt on BuildContext {
  String toPrice(double? price) {
    if (price != null) {
      // final prices = double.parse(price);
      final result = "${price.toStringAsFixed(2)} ${Strings.cruncy2.tr()}";
      return result;
    } else {
      return Strings.cruncy2.tr();
    }
  }

  String toDoube(double? price) {
    if (price != null) {
      // final prices = double.parse(price);
      final result = price.toStringAsFixed(2);
      return result;
    } else {
      return "0.0".tr();
    }
  }

  // * price
  String toPrice2(double? price) {
    if (price != null) {
      // final prices = double.parse(price);
      final result = "${price.toStringAsFixed(1)} ${Strings.cruncy.tr()}";
      return result;
    } else {
      return Strings.cruncy.tr();
    }
  }

  String toDistance(double? distance) {
    if (distance != null) {
      // final prices = double.parse(price);
      final result = "${distance.toStringAsFixed(2)} ${Strings.km.tr()}";
      return result;
    } else {
      return Strings.km.tr();
    }
  }

  String toStatus(int status) {
    return status == 0 ?Strings.opend.tr() :Strings.closed.tr();
  }

  String convertDate(String dateValue) {
    DateTime date = DateTime.parse(dateValue);
    final DateFormat formatter =
        DateFormat('yyyy-MM-dd :  hh:mm a', AppModel.lang);
    final String formatted = formatter.format(date);
    return formatted;
  }


  String convertDateDay(String dateValue) {
    DateTime date = DateTime.parse(dateValue);
    final DateFormat formatter =
        DateFormat('EEEE, d MMM, yyyy', AppModel.lang);
    final String formatted = formatter.format(date);
    return formatted;
  }


  String convertTime(String dateValue) {
    DateTime date = DateTime.parse(dateValue);
    final DateFormat formatter = DateFormat('hh:mm a', AppModel.lang);
    final String formatted = formatter.format(date);
    return formatted;
  }

  String getImageProduct(String images) {
    return images.split("#")[0];
  }

  OrderStatusModel getOrderStatus(int value) {
    return orderStatus.firstWhere((element) => element.id == value);
  }

  bool isCleint(String role) {
    return role == ApiConstants.client;
  }

  bool isResturant(String role) {
    return role == ApiConstants.restaurant;
  }

  bool isDelivary(String role) {
    return role == ApiConstants.delivery;
  }

  OrderStatusModel getColorOrderStatus(int status) {
    return orderStatus.firstWhere((element) => element.id == status);
  }

  
}
