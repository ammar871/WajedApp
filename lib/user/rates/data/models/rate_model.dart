import 'package:freezed_annotation/freezed_annotation.dart';
part 'rate_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class RateModel {
  final int id;
  final int typeId;
  final String userId;
  final String comment;
  final String type;
  final int stare;
  final String createAte;

  RateModel(
      {required this.typeId,
      required this.userId,
      required this.comment,
      required this.type,
      required this.id,
      required this.createAte,
      required this.stare});

  Map<String, dynamic> toJson() => _$RateModelToJson(this);

  factory RateModel.fromJson(Map<String, dynamic> json) =>
      _$RateModelFromJson(json);
}

@JsonSerializable()
class AddRateResponse {
  final String message;
  final RateModel rate;

  AddRateResponse({required this.message, required this.rate});


  Map<String, dynamic> toJson() => _$AddRateResponseToJson(this);

  factory AddRateResponse.fromJson(Map<String, dynamic> json) =>
      _$AddRateResponseFromJson(json);
}
