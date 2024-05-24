import 'package:wajed_app/common/app/data/models/bas_models/base_response_model.dart';
import 'package:wajed_app/common/order/data/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/driver/data/models/home_response_driver.dart';
import '../../../../market/market/data/models/market_model.dart';
part 'order_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class OrderResponse extends BaseResponseModel {
  final List<OrderUserData> items;

  OrderResponse({required this.items, required super.totalPages, required super.currentPage,});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrderUserData {
  final OrderModel order;
  final MarketModel market;

  OrderUserData({required this.order, required this.market});

  factory OrderUserData.fromJson(Map<String, dynamic> json) =>
      _$OrderUserDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderUserDataToJson(this);
}

@JsonSerializable()
class OrderDriverResponse extends BaseResponseModel {
  final List<OrderDriver> items;

  OrderDriverResponse(
      {required super.totalPages,
      required super.currentPage,
      required this.items});

  factory OrderDriverResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDriverResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDriverResponseToJson(this);
}
