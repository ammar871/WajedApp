// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'] as int,
      productId: json['productId'] as int,
      marketId: json['marketId'] as int,
      quantity: json['quantity'] as int,
      status: json['status'] as int,
      nots: json['nots'] as String?,
      orderId: json['orderId'] as int,
      cost: (json['cost'] as num).toDouble(),
      userId: json['userId'] as String,
      optionsIds: json['optionsIds'] as String?,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'marketId': instance.marketId,
      'quantity': instance.quantity,
      'status': instance.status,
      'orderId': instance.orderId,
      'cost': instance.cost,
      'userId': instance.userId,
      'optionsIds': instance.optionsIds,
      'nots': instance.nots,
      'createdAt': instance.createdAt,
    };

CartDeatails _$CartDeatailsFromJson(Map<String, dynamic> json) => CartDeatails(
      cart: CartModel.fromJson(json['cart'] as Map<String, dynamic>),
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDeatailsToJson(CartDeatails instance) =>
    <String, dynamic>{
      'cart': instance.cart,
      'product': instance.product,
      'options': instance.options,
    };

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      carts: (json['carts'] as List<dynamic>)
          .map((e) => CartDeatails.fromJson(e as Map<String, dynamic>))
          .toList(),
      productsCost: (json['productsCost'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      couponDetails: CouponResponse.fromJson(
          json['couponDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'carts': instance.carts,
      'productsCost': instance.productsCost,
      'totalCost': instance.totalCost,
      'deliveryCost': instance.deliveryCost,
      'tax': instance.tax,
      'couponDetails': instance.couponDetails,
    };
