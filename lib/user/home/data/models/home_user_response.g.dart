// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeUserResponse _$HomeUserResponseFromJson(Map<String, dynamic> json) =>
    HomeUserResponse(
      markets: (json['markets'] as List<dynamic>)
          .map((e) => MarketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => FieldModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List<dynamic>)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasDefaultAddress: json['hasDefaultAddress'] as bool,
      userDetail: json['userDetail'] == null
          ? null
          : UserModel.fromJson(json['userDetail'] as Map<String, dynamic>),
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => FavorateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultAddress: json['defaultAddress'] == null
          ? null
          : AddressModel.fromJson(
              json['defaultAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeUserResponseToJson(HomeUserResponse instance) =>
    <String, dynamic>{
      'markets': instance.markets,
      'fields': instance.fields,
      'offers': instance.offers,
      'favorites': instance.favorites,
      'userDetail': instance.userDetail,
      'defaultAddress': instance.defaultAddress,
      'hasDefaultAddress': instance.hasDefaultAddress,
    };
