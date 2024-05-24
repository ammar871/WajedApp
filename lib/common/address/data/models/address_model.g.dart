// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as int,
      userId: json['userId'] as String,
      description: json['description'] as String,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      defaultAddress: json['defaultAddress'] as bool,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'description': instance.description,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'defaultAddress': instance.defaultAddress,
      'createdAt': instance.createdAt,
    };
