// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrderBody _$AddOrderBodyFromJson(Map<String, dynamic> json) => AddOrderBody(
      userId: json['userId'] as String,
      addressId: json['addressId'] as int,
      marketId: json['marketId'] as int,
      payment: json['payment'] as int,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AddOrderBodyToJson(AddOrderBody instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'userId': instance.userId,
      'marketId': instance.marketId,
      'payment': instance.payment,
      'notes': instance.notes,
    };
