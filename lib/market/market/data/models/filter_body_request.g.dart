// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_body_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterBodyRequest _$FilterBodyRequestFromJson(Map<String, dynamic> json) =>
    FilterBodyRequest(
      byRate: json['byRate'] as int?,
      byMostOrders: json['byMostOrders'] as int?,
      fieldId: json['fieldId'] as int?,
      page: json['page'] as int,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$FilterBodyRequestToJson(FilterBodyRequest instance) =>
    <String, dynamic>{
      'byRate': instance.byRate,
      'byMostOrders': instance.byMostOrders,
      'fieldId': instance.fieldId,
      'page': instance.page,
      'userId': instance.userId,
    };
