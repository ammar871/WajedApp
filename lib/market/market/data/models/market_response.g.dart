// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketResponse _$MarketResponseFromJson(Map<String, dynamic> json) =>
    MarketResponse(
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => MarketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarketResponseToJson(MarketResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'items': instance.items,
    };
