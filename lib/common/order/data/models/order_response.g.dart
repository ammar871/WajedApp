// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderUserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'items': instance.items,
    };

OrderUserData _$OrderUserDataFromJson(Map<String, dynamic> json) =>
    OrderUserData(
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      market: MarketModel.fromJson(json['market'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderUserDataToJson(OrderUserData instance) =>
    <String, dynamic>{
      'order': instance.order,
      'market': instance.market,
    };

OrderDriverResponse _$OrderDriverResponseFromJson(Map<String, dynamic> json) =>
    OrderDriverResponse(
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderDriver.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDriverResponseToJson(
        OrderDriverResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'items': instance.items,
    };
