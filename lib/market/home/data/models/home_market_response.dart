import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/common/app/data/models/bas_models/success_responnse.dart';
import 'package:wajed_app/common/chate/data/models/conversation_response.dart';
import 'package:wajed_app/common/order/data/models/order_details_response.dart';
import 'package:wajed_app/common/order/data/models/order_model.dart';
import 'package:wajed_app/common/category/data/models/category_model.dart';
import 'package:wajed_app/common/product/data/models/option_model.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';
import '../../../market/data/models/market_model.dart';

part 'home_market_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class HomeResponseMarket extends SuccessResponse {
  final HomeMarketData? data;
  HomeResponseMarket(
      {this.data, required super.status, required super.message});

  factory HomeResponseMarket.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseMarketFromJson(json);
}

@JsonSerializable()
class HomeMarketData {
  final MarketModel market;
  final double receipts;
  final int successfulOrders;
  final int otherOrders;
  final List<OrderRsponseMarket> lastOrders;
  final List<CategoryModel> categories;
  final List<ConversationResponse> conversations;
  HomeMarketData(
      {required this.market,
      required this.receipts,
      required this.successfulOrders,required this.categories, 
      required this.otherOrders,
      required this.conversations,
      required this.lastOrders});

  factory HomeMarketData.fromJson(Map<String, dynamic> json) =>
      _$HomeMarketDataFromJson(json);
}

@JsonSerializable()
class OrderRsponseMarket {
  final OrderModel order;
  final List<OrderItemResponseMarket> orderItems;

  OrderRsponseMarket({required this.order, required this.orderItems});

  factory OrderRsponseMarket.fromJson(Map<String, dynamic> json) =>
      _$OrderRsponseMarketFromJson(json);
}

@JsonSerializable()
class OrderItemResponseMarket {
  final OrderItem orderItem;
  final ProductMarketResponse productResponse;

  OrderItemResponseMarket(
      {required this.orderItem, required this.productResponse});

  factory OrderItemResponseMarket.fromJson(Map<String, dynamic> json) =>
      _$OrderItemResponseMarketFromJson(json);
}

@JsonSerializable()
class ProductMarketResponse {
  final ProductModel product;
  final List<OptionModel> options;

  ProductMarketResponse({required this.product, required this.options});

  factory ProductMarketResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductMarketResponseFromJson(json);
}
