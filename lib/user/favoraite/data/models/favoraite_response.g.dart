// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoraite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoraiteResponse _$FavoraiteResponseFromJson(Map<String, dynamic> json) =>
    FavoraiteResponse(
      FavorateModel.fromJson(json['favorite'] as Map<String, dynamic>),
      MarketModel.fromJson(json['market'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoraiteResponseToJson(FavoraiteResponse instance) =>
    <String, dynamic>{
      'favorite': instance.favorite,
      'market': instance.market,
    };
