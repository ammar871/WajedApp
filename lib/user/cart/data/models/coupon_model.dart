
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class CouponModel {

  final int id;

  final String userId;

  final String code;

  final double discount;

  final double minPrice;

  final int useCount;

  final int maxUseCount;

  final String startDate;

  final String endDate;

  CouponModel(
      {required this.id,
      required this.userId,
      required this.code,
      required this.discount,
      required this.minPrice,
      required this.useCount,
      required this.maxUseCount,
      required this.startDate,
      required this.endDate});

      factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);


  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}

@JsonSerializable()
class CouponResponse{
  //    public string? Status { get; set; }

  //  public string? Message { get; set; }

  //  public Coupon? coupon { get; set; }

  final String? status;
  final String? message;
  final CouponModel? coupon;
  CouponResponse({this.status, this.message, this.coupon});

  factory CouponResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseFromJson(json);


  Map<String, dynamic> toJson() => _$CouponResponseToJson(this);
}