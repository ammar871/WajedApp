import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';
//dart run build_runner build
@JsonSerializable()
class ProductModel {
  final int id;
  final String nameAr;
  final String nameEng;
  final String imageUrl;
  final String descAr;
  final String descEng;
  final bool isCart;
  final double price;
  // final String calories;
  final int fieldId;
  final int categoryId;
  final int marketId;
  final int status;
  final DateTime createdAt;
  ProductModel({
    required this.id,
    required this.nameAr,
    required this.nameEng,
    required this.imageUrl,
    required this.descAr,
    required this.descEng,
    required this.isCart,
    required this.price,
  
    required this.fieldId,
    required this.categoryId,
    required this.marketId,
    required this.status,
    required this.createdAt,
  });


  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);


}
