import 'package:json_annotation/json_annotation.dart';

part 'add_market_body_request.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddMarketBodyRequest {
  final int fieldId;
  final String titleAr;
  final String titleEng;
  final String descAr;
  final String descEng;
  final String userId;
  final String imageLogo;
  final String imageCommercial;
  final String addressName;
   final String password;
   final String nameOwner;
  final double lat;
  final double lng;

  AddMarketBodyRequest(
      {required this.fieldId,
      required this.titleAr,
      required this.titleEng,
      required this.descAr,
      required this.descEng,
      required this.userId,
      required this.nameOwner,
      required this.imageLogo,
      required this.password,
      required this.imageCommercial,
      required this.addressName,
      required this.lat,
      required this.lng});

      // to json

  Map<String, dynamic> toJson() => _$AddMarketBodyRequestToJson(this);
}
