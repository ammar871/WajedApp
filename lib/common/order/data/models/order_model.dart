
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.g.dart';

//dart run build_runner build
@JsonSerializable()
class OrderModel {
  final int id;
  final int marketId;
  final int status;
  final String? userId;
  final double totalCost;
  final double tax;
   final double rate;
  final double deliveryCost;
  final double productsCost;
  final int? driverId;
  final int payment;
  final String? notes;
  final String createdAt;

  OrderModel(
      {required this.id,
      required this.marketId,
      required this.status,
      required this.userId,
      required this.totalCost,
      required this.tax,
       required this.rate,
      required this.deliveryCost,
      required this.productsCost,
      required this.driverId,
      required this.payment,
      required this.notes,
      required this.createdAt});

      factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);


}
