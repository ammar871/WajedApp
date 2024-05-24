import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/app/data/models/bas_models/success_responnse.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';

import 'package:wajed_app/common/order/data/models/order_model.dart';

import 'driver_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_response_driver.g.dart';

//dart run build_runner build
@JsonSerializable()
class HomeDriverResponse extends SuccessResponse {
  final HomeDriverData? data;
  HomeDriverResponse(
      {required this.data, required super.status, required super.message});

  factory HomeDriverResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDriverResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDriverResponseToJson(this);
}


@JsonSerializable()
class OrderDriver {
  final OrderModel order;
  final AddressModel address;

  OrderDriver({required this.order, required this.address});

  factory OrderDriver.fromJson(Map<String, dynamic> json) =>
      _$OrderDriverFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDriverToJson(this);

}

@JsonSerializable()
class HomeDriverData {
  final DriverModel? driver;
  final UserModel userDetail;
  final List<OrderDriver> currentOrders;
  final List<OrderDriver> myOrders;

  HomeDriverData(this.driver, this.userDetail, this.currentOrders,this.myOrders);

  factory HomeDriverData.fromJson(Map<String, dynamic> json) =>
      _$HomeDriverDataFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDriverDataToJson(this);
}
