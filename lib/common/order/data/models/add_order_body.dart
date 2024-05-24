
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_order_body.g.dart';

//dart run build_runner build
@JsonSerializable()
class AddOrderBody {
  final int addressId;
  final String userId;
  final int marketId;
  final int payment;
  final String? notes;

  AddOrderBody({required this.userId,required this.addressId, required this.marketId, required this.payment, required this.notes});



  Map<String, dynamic> toJson() => _$AddOrderBodyToJson(this);


}

