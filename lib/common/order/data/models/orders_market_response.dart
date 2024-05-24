import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/common/base_models/base_response.dart';
import 'package:wajed_app/common/order/data/models/order_model.dart';
part 'orders_market_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class OrdersMarketResponse extends BaseResponse {
  final List<OrderModel> items;
  OrdersMarketResponse(
      {required this.items,
      required super.currentPage,
      required super.totalPages});


       // from json 
  factory OrdersMarketResponse.fromJson(Map<String, dynamic> json) => _$OrdersMarketResponseFromJson(json);
}
