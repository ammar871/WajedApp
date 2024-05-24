import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/user/home/data/models/field_model.dart';

import 'package:wajed_app/user/offers/data/models/offfer_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../market/market/data/models/market_model.dart';
import '../../../favoraite/data/models/favoraite_model.dart';
part 'home_user_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class HomeUserResponse {
  final List<MarketModel> markets;
  final List<FieldModel> fields;
  final List<OfferModel> offers;
   final List<FavorateModel> favorites;
  final UserModel? userDetail;
  final AddressModel? defaultAddress;
  final bool hasDefaultAddress;

  HomeUserResponse(
      {required this.markets,
      required this.fields,
      required this.offers,  
       required this.hasDefaultAddress,
      required this.userDetail, required this.favorites,
      required this.defaultAddress});

  factory HomeUserResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeUserResponseToJson(this);
}
