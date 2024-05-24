import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:wajed_app/common/product/data/models/options_response.dart';

import 'product_model.dart';

part 'product_details_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class ProductDetailsResponse {
  final ProductModel product;
 
  final List<OptionsResponse> options;

  ProductDetailsResponse({
    required this.product,

    required this.options,
  });



  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseToJson(this);
}
