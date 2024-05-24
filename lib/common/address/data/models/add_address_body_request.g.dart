// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_address_body_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAddressBodyReqquest _$AddAddressBodyReqquestFromJson(
        Map<String, dynamic> json) =>
    AddAddressBodyReqquest(
      userId: json['userId'] as String,
      id: json['id'] as int?,
      description: json['description'] as String,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      defaultAddress: json['defaultAddress'] as bool,
    );

Map<String, dynamic> _$AddAddressBodyReqquestToJson(
        AddAddressBodyReqquest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'description': instance.description,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'defaultAddress': instance.defaultAddress,
    };
