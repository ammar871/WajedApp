// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductBody _$AddProductBodyFromJson(Map<String, dynamic> json) =>
    AddProductBody(
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      imageUrl: json['imageUrl'] as String,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['categoryId'] as int,
      marketId: json['marketId'] as int,
    );

Map<String, dynamic> _$AddProductBodyToJson(AddProductBody instance) =>
    <String, dynamic>{
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'imageUrl': instance.imageUrl,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'marketId': instance.marketId,
    };
