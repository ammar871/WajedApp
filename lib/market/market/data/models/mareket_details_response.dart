import 'package:wajed_app/common/category/data/models/category_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'market_model.dart';
part 'mareket_details_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class MarketDetailsResponse {
  final MarketModel market;
  final List<CategoryModel> categories;

  MarketDetailsResponse({required this.market, required this.categories});

  factory MarketDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MarketDetailsResponseToJson(this);
}
