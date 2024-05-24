
import 'package:freezed_annotation/freezed_annotation.dart';
part 'alert_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class AlertModel {
  final int id;
  final String userId;
  final String titleAr;
  final String titleEng;
  final String descAr;
  final String descEng;
  final String? page;
    final String type;
  final int pageId;
  final String createdAt;

  AlertModel(
      {required this.id,
      required this.userId,
      required this.titleAr,
      required this.titleEng,
      required this.descAr,
      required this.descEng,
      required this.page,
      required this.type,
      required this.pageId,
      required this.createdAt});


      factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}



