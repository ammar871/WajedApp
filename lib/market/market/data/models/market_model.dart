import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_model.g.dart';



//dart run build_runner build
@JsonSerializable()
class MarketModel {
  final int id;
  final int fieldId;

  final String titleAr;
  final String descAr;
  final String titleEng;
  final String descEng;
  final String userId;
  final String nameOwner;
  final String password;

    final String imageLogo;
  final String imageCommercial;
  final String addressName;

  final dynamic  minimum;
  final dynamic dlivaryCost;
  final String timeDelvary;
  final double lat;
  final double lng;
  final double rate;
  final int status;
  final double discount;
  final double distance;
  final int orderCount;
  final String createdAt;

  factory MarketModel.fromJson(Map<String, dynamic> json) =>
      _$MarketModelFromJson(json);

  MarketModel(
    
      this.id,
      this.fieldId, this.orderCount,
      this.titleAr,
      this.descAr,
      this.titleEng,
      this.descEng,
      this.userId,
      this.nameOwner,
      this.password,
      this.addressName,
      this.lat,
      this.lng,
      this.rate,
      this.status,
      this.discount,
      this.distance,
      this.createdAt,
      this.imageLogo,
      this.imageCommercial, this.minimum, this.dlivaryCost, this.timeDelvary);

  Map<String, dynamic> toJson() => _$MarketModelToJson(this);
}
