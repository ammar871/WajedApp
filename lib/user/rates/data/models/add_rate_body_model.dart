import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_rate_body_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddRateBodyModel {
  final int typeId;
  final String userId;
  final String comment;
  final String type;
  final int stare;

  AddRateBodyModel(
      {required this.typeId,
      required this.userId,
      required this.comment,
      required this.type,
      required this.stare});


  Map<String, dynamic> toJson() => _$AddRateBodyModelToJson(this);

  
}
