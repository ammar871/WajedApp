// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int,
      marketId: json['marketId'] as int,
      status: json['status'] as int,
      userId: json['userId'] as String?,
      totalCost: (json['totalCost'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      productsCost: (json['productsCost'] as num).toDouble(),
      driverId: json['driverId'] as int?,
      payment: json['payment'] as int,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'marketId': instance.marketId,
      'status': instance.status,
      'userId': instance.userId,
      'totalCost': instance.totalCost,
      'tax': instance.tax,
      'rate': instance.rate,
      'deliveryCost': instance.deliveryCost,
      'productsCost': instance.productsCost,
      'driverId': instance.driverId,
      'payment': instance.payment,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
    };
