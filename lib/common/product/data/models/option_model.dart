import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_model.g.dart';
//dart run build_runner build
@JsonSerializable()
class OptionModel {
    // "id": 1,
    //         "groupId": 1,
    //         "productId": 0,
    //         "nameAr": "بوكس",
    //         "nameEng": "Box",
    //         "price": 100

    final int id;
     int groupId;
    final int productId;
    final String nameAr;
    final String nameEng;
    final double price;

    OptionModel({
        required this.id,
        required this.groupId,
        required this.productId,
        required this.nameAr,
        required this.nameEng,
        required this.price,
    });

    factory OptionModel.fromJson(Map<String, dynamic> json) => _$OptionModelFromJson(json);
    Map<String, dynamic> toJson() => _$OptionModelToJson(this);



}