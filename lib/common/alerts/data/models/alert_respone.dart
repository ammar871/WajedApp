import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wajed_app/common/app/data/models/bas_models/base_response_model.dart';
import 'alert_model.dart';
part 'alert_respone.g.dart';

//dart run build_runner build
@JsonSerializable()
class AlertResponse extends BaseResponseModel {
  final List<AlertModel> items;
  AlertResponse({required super.totalPages, required super.currentPage, required this.items});

   
   factory AlertResponse.fromJson(Map<String, dynamic> json) => _$AlertResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlertResponseToJson(this);
  
} 
