import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/market/market/data/models/market_model.dart';
import 'package:wajed_app/user/favoraite/data/models/favoraite_model.dart';

part 'favoraite_response.g.dart';
@JsonSerializable()
class FavoraiteResponse {
  final FavorateModel favorite;
  final MarketModel market;

  FavoraiteResponse(this.favorite, this.market);

  //make function from json 
  factory FavoraiteResponse.fromJson(Map<String, dynamic> json) => _$FavoraiteResponseFromJson(json);


  


  
}
