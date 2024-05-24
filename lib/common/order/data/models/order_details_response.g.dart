// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsResponse _$OrderDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    OrderDetailsResponse(
      json['driver'] == null
          ? null
          : DriverResponse.fromJson(json['driver'] as Map<String, dynamic>),
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      market: MarketModel.fromJson(json['market'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsResponseToJson(
        OrderDetailsResponse instance) =>
    <String, dynamic>{
      'order': instance.order,
      'products': instance.products,
      'address': instance.address,
      'market': instance.market,
      'user': instance.user,
      'driver': instance.driver,
    };

OrderItemResponse _$OrderItemResponseFromJson(Map<String, dynamic> json) =>
    OrderItemResponse(
      cart: OrderItem.fromJson(json['cart'] as Map<String, dynamic>),
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderItemResponseToJson(OrderItemResponse instance) =>
    <String, dynamic>{
      'cart': instance.cart,
      'product': instance.product,
      'options': instance.options,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as int,
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
      options: json['options'] as String?,
      orderId: json['orderId'] as int,
      cost: (json['cost'] as num).toDouble(),
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'options': instance.options,
      'orderId': instance.orderId,
      'cost': instance.cost,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
    };
