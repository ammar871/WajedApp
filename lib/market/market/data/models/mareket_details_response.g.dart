// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mareket_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketDetailsResponse _$MarketDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MarketDetailsResponse(
      market: MarketModel.fromJson(json['market'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarketDetailsResponseToJson(
        MarketDetailsResponse instance) =>
    <String, dynamic>{
      'market': instance.market,
      'categories': instance.categories,
    };
