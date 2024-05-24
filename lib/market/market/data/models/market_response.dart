import 'package:json_annotation/json_annotation.dart';

import '../../../../common/app/data/models/bas_models/base_response_model.dart';
import 'market_model.dart';
part 'market_response.g.dart';

@JsonSerializable()
class MarketResponse extends BaseResponseModel {
  final List<MarketModel> items;
  MarketResponse(
      {required super.totalPages,
      required super.currentPage,
      required this.items});

      factory MarketResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketResponseToJson(this);

}
