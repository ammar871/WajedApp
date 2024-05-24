import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_body.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddProductBody {
  final String nameAr;
  final String nameEng;
  final String imageUrl;
  final String descAr;
  final String descEng;
  final double price;
  final int categoryId;
  final int marketId;

  AddProductBody(
      {required this.nameAr,
      required this.nameEng,
      required this.imageUrl,
      required this.descAr,
      required this.descEng,
    
      required this.price,
      required this.categoryId,
      required this.marketId});

      factory AddProductBody.fromJson(Map<String, dynamic> json) =>
      _$AddProductBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductBodyToJson(this);
}
