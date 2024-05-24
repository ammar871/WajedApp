// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      imageUrl: json['imageUrl'] as String,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      isCart: json['isCart'] as bool,
      price: (json['price'] as num).toDouble(),
      fieldId: json['fieldId'] as int,
      categoryId: json['categoryId'] as int,
      marketId: json['marketId'] as int,
      status: json['status'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'imageUrl': instance.imageUrl,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'isCart': instance.isCart,
      'price': instance.price,
      'fieldId': instance.fieldId,
      'categoryId': instance.categoryId,
      'marketId': instance.marketId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
