// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDriverResponse _$HomeDriverResponseFromJson(Map<String, dynamic> json) =>
    HomeDriverResponse(
      data: json['data'] == null
          ? null
          : HomeDriverData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$HomeDriverResponseToJson(HomeDriverResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

OrderDriver _$OrderDriverFromJson(Map<String, dynamic> json) => OrderDriver(
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDriverToJson(OrderDriver instance) =>
    <String, dynamic>{
      'order': instance.order,
      'address': instance.address,
    };

HomeDriverData _$HomeDriverDataFromJson(Map<String, dynamic> json) =>
    HomeDriverData(
      json['driver'] == null
          ? null
          : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
      UserModel.fromJson(json['userDetail'] as Map<String, dynamic>),
      (json['currentOrders'] as List<dynamic>)
          .map((e) => OrderDriver.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['myOrders'] as List<dynamic>)
          .map((e) => OrderDriver.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDriverDataToJson(HomeDriverData instance) =>
    <String, dynamic>{
      'driver': instance.driver,
      'userDetail': instance.userDetail,
      'currentOrders': instance.currentOrders,
      'myOrders': instance.myOrders,
    };
