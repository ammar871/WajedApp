import 'package:wajed_app/common/auth/data/models/user_response.dart';
import 'package:wajed_app/common/base_models/base_response.dart';
import 'package:wajed_app/common/chate/data/models/conversation_model.dart';
import 'package:wajed_app/common/chate/data/models/message_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_response.g.dart';

//dart run build_runner build
@JsonSerializable()
class ConversationResponse {
  final ConversationModel conversation;
  final UserModel user;
  final UserModel otherUser;
  final MessageModel lastMessage;

  ConversationResponse(
      {required this.conversation,
      required this.user,
      required this.otherUser,
      required this.lastMessage});

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationResponseToJson(this);
}

@JsonSerializable()
class ConversationResponseSuccess {
  final bool status;
  final ConversationModel? conversation;

  ConversationResponseSuccess(
      {required this.status, required this.conversation});

  factory ConversationResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationResponseSuccessToJson(this);
}

@JsonSerializable()
class ConversationResponsePage extends BaseResponse {
  final List<ConversationResponse> items;
  ConversationResponsePage(
      {required super.currentPage, required super.totalPages,required this.items});


      factory ConversationResponsePage.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponsePageFromJson(json);
}
