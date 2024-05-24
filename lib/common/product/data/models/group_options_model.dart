import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_options_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class GroupOptionsModel {
  // "id": 1,
  //           "nameAr": "الانواع",
  //           "nameEng": "الانواع"

  final int id;
  final String nameAr;
  final String nameEng;
  final int productId;

  GroupOptionsModel(
      {required this.id, required this.nameAr, required this.nameEng,
      required this.productId,
      
      });

  factory GroupOptionsModel.fromJson(Map<String, dynamic> json) =>
      _$GroupOptionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GroupOptionsModelToJson(this);
}
