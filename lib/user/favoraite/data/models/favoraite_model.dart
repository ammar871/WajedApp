import 'package:freezed_annotation/freezed_annotation.dart';

part 'favoraite_model.g.dart';
@JsonSerializable()
class FavorateModel {
  final int id;
  final String? userId;
  final int marketId;
  final String createdAt;

  FavorateModel(this.id, this.userId, this.marketId, this.createdAt);

  /// from json 
   factory FavorateModel.fromJson(Map<String, dynamic> json) =>
      _$FavorateModelFromJson(json);
   
}
