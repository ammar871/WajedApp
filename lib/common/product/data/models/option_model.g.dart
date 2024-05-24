// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionModel _$OptionModelFromJson(Map<String, dynamic> json) => OptionModel(
      id: json['id'] as int,
      groupId: json['groupId'] as int,
      productId: json['productId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'productId': instance.productId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'price': instance.price,
    };
