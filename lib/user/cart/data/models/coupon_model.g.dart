// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel(
      id: json['id'] as int,
      userId: json['userId'] as String,
      code: json['code'] as String,
      discount: (json['discount'] as num).toDouble(),
      minPrice: (json['minPrice'] as num).toDouble(),
      useCount: json['useCount'] as int,
      maxUseCount: json['maxUseCount'] as int,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'code': instance.code,
      'discount': instance.discount,
      'minPrice': instance.minPrice,
      'useCount': instance.useCount,
      'maxUseCount': instance.maxUseCount,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

CouponResponse _$CouponResponseFromJson(Map<String, dynamic> json) =>
    CouponResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      coupon: json['coupon'] == null
          ? null
          : CouponModel.fromJson(json['coupon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CouponResponseToJson(CouponResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'coupon': instance.coupon,
    };
