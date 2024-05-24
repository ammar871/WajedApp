// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_body_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartBodyRequest _$AddCartBodyRequestFromJson(Map<String, dynamic> json) =>
    AddCartBodyRequest(
      quantity: json['quantity'] as int,
      cost: json['cost'] as int,
      nots: json['nots'] as String?,
      userId: json['userId'] as String,
      productId: json['productId'] as int,
      optionsIds: json['optionsIds'] as String?,
    );

Map<String, dynamic> _$AddCartBodyRequestToJson(AddCartBodyRequest instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'cost': instance.cost,
      'userId': instance.userId,
      'productId': instance.productId,
      'optionsIds': instance.optionsIds,
      'nots': instance.nots,
    };
