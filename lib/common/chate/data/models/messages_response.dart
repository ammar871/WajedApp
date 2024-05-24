import 'package:wajed_app/common/base_models/base_response.dart';
import 'message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'messages_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class MessagesResponse extends BaseResponse {
  final List<MessageModel> items;

  MessagesResponse(
      {required super.currentPage,
      required super.totalPages,
      required this.items});

  // * from json

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseFromJson(json);

  /// * to json
  Map<String, dynamic> toJson() => _$MessagesResponseToJson(this);
}
