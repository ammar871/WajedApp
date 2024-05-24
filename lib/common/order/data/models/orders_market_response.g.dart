// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_market_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersMarketResponse _$OrdersMarketResponseFromJson(
        Map<String, dynamic> json) =>
    OrdersMarketResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
    );

Map<String, dynamic> _$OrdersMarketResponseToJson(
        OrdersMarketResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
