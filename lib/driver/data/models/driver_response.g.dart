// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverResponse _$DriverResponseFromJson(Map<String, dynamic> json) =>
    DriverResponse(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      driver: json['driver'] == null
          ? null
          : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DriverResponseToJson(DriverResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'driver': instance.driver,
    };
