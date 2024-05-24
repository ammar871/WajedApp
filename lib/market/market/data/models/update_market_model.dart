import 'package:json_annotation/json_annotation.dart';

part 'update_market_model.g.dart';

@JsonSerializable()
class UpdateMarketModel {
  final int marketId;
  final int fieldId;
  final String titleAr;
  final String titleEng;
  final String descAr;
  final String descEng;
  final String imageLogo;
  final String imageCommercial;
  final String addressName;
  final String nameOwner;
  final String password;
  final double lat;
  final double lng;

  factory UpdateMarketModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateMarketModelFromJson(json);

  UpdateMarketModel(
      {required this.marketId,
      required this.fieldId,
      required this.titleAr,
      required this.titleEng,
      required this.descAr,
      required this.descEng,
      required this.imageLogo,
      required this.imageCommercial,
      required this.addressName,
      required this.nameOwner,
      required this.password,
      required this.lat,
      required this.lng});

  Map<String, dynamic> toJson() => _$UpdateMarketModelToJson(this);
}
