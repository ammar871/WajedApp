import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/common/order/data/models/order_model.dart';
import 'package:wajed_app/common/product/data/models/option_model.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/driver/data/models/driver_response.dart';
import '../../../../market/market/data/models/market_model.dart';
part 'order_details_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class OrderDetailsResponse {
  final OrderModel order;
  final List<OrderItemResponse> products;
  final AddressModel address;
  final MarketModel market;
  final UserModel user;
  final DriverResponse? driver;

  OrderDetailsResponse(this.driver,
      {required this.order,
      required this.products,
      required this.address,
      required this.user,
      required this.market});

  // from json

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsResponseToJson(this);
}

@JsonSerializable()
class OrderItemResponse {
  final OrderItem cart;
  final ProductModel product;
  final List<OptionModel>? options;

  OrderItemResponse(
      {required this.cart, required this.product, required this.options});

  // from json
  factory OrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemResponseToJson(this);
}

@JsonSerializable()
class OrderItem {
  final int id;
  final int productId;
  final int quantity;
  final String? options;
  final int orderId;
  final double cost;
  final String userId;
  final String createdAt;

  OrderItem(
      {required this.id,
      required this.productId,
      required this.quantity,
      required this.options,
      required this.orderId,
      required this.cost,
      required this.userId,
      required this.createdAt});

  // from json
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
