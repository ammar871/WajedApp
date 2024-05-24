import 'package:freezed_annotation/freezed_annotation.dart';

part 'offfer_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class OfferModel {
  final int id;
  final String image;
  final String? icon;
  final int status;
  final String descAr;
  final String descEng;
  final String createdAt;

  OfferModel(
      {required this.id,
      required this.image,
      required this.status,
      required this.icon,
      required this.descAr,
      required this.descEng,
      required this.createdAt});

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
