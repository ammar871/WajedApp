import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/common/product/data/models/product_model.dart';

import '../../../base_models/base_response.dart';

part 'productes_response.g.dart';
//dart run build_runner build
@JsonSerializable()
class ProductsResponse extends BaseResponse {
  final List<ProductModel> items;

  ProductsResponse({required this.items, required super.currentPage, required super.totalPages});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) => _$ProductsResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);


}
