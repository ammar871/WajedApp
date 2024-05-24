// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_market_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponseMarket _$HomeResponseMarketFromJson(Map<String, dynamic> json) =>
    HomeResponseMarket(
      data: json['data'] == null
          ? null
          : HomeMarketData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$HomeResponseMarketToJson(HomeResponseMarket instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

HomeMarketData _$HomeMarketDataFromJson(Map<String, dynamic> json) =>
    HomeMarketData(
      market: MarketModel.fromJson(json['market'] as Map<String, dynamic>),
      receipts: (json['receipts'] as num).toDouble(),
      successfulOrders: json['successfulOrders'] as int,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherOrders: json['otherOrders'] as int,
      conversations: (json['conversations'] as List<dynamic>)
          .map((e) => ConversationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastOrders: (json['lastOrders'] as List<dynamic>)
          .map((e) => OrderRsponseMarket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeMarketDataToJson(HomeMarketData instance) =>
    <String, dynamic>{
      'market': instance.market,
      'receipts': instance.receipts,
      'successfulOrders': instance.successfulOrders,
      'otherOrders': instance.otherOrders,
      'lastOrders': instance.lastOrders,
      'categories': instance.categories,
      'conversations': instance.conversations,
    };

OrderRsponseMarket _$OrderRsponseMarketFromJson(Map<String, dynamic> json) =>
    OrderRsponseMarket(
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((e) =>
              OrderItemResponseMarket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderRsponseMarketToJson(OrderRsponseMarket instance) =>
    <String, dynamic>{
      'order': instance.order,
      'orderItems': instance.orderItems,
    };

OrderItemResponseMarket _$OrderItemResponseMarketFromJson(
        Map<String, dynamic> json) =>
    OrderItemResponseMarket(
      orderItem: OrderItem.fromJson(json['orderItem'] as Map<String, dynamic>),
      productResponse: ProductMarketResponse.fromJson(
          json['productResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemResponseMarketToJson(
        OrderItemResponseMarket instance) =>
    <String, dynamic>{
      'orderItem': instance.orderItem,
      'productResponse': instance.productResponse,
    };

ProductMarketResponse _$ProductMarketResponseFromJson(
        Map<String, dynamic> json) =>
    ProductMarketResponse(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductMarketResponseToJson(
        ProductMarketResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'options': instance.options,
    };
