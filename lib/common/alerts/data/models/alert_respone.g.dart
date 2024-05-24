// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_respone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertResponse _$AlertResponseFromJson(Map<String, dynamic> json) =>
    AlertResponse(
      totalPages: json['totalPages'] as int,
      currentPage: json['currentPage'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlertResponseToJson(AlertResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'items': instance.items,
    };
