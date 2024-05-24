import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/common/product/data/models/option_model.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';

import 'coupon_model.dart';

part 'cart_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class CartModel {
  final int id;
  final int productId;
  final int marketId;
  final int quantity;
  final int status;
  final int orderId;
  final double cost;
  final String userId;
  final String? optionsIds;
  final String? nots;
  final String createdAt;

  CartModel(
      {required this.id,
      required this.productId,
      required this.marketId,
      required this.quantity,
      required this.status,      required this.nots,
      required this.orderId,
      required this.cost,
      required this.userId,
      required this.optionsIds,
      required this.createdAt});

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class CartDeatails {
  final CartModel cart;
  final ProductModel product;
  final List<OptionModel> options;

  CartDeatails(
      {required this.cart, required this.product, required this.options});

  factory CartDeatails.fromJson(Map<String, dynamic> json) =>
      _$CartDeatailsFromJson(json);

  Map<String, dynamic> toJson() => _$CartDeatailsToJson(this);
}

@JsonSerializable()
class CartResponse {
  final List<CartDeatails> carts;
  final double productsCost;
  final double totalCost;
  final double deliveryCost;
  final double tax;
  final CouponResponse couponDetails;

  CartResponse(
      {required this.carts,
      required this.productsCost,
      required this.totalCost,
      required this.deliveryCost,
      required this.tax,
      required this.couponDetails});

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
