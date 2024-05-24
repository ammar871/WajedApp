import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_model.g.dart';
//dart run build_runner build
@JsonSerializable()
class ConversationModel {
  final int id;
  final String userOne;
  final String userTwo;
  final int status;
  final DateTime createAt;

  ConversationModel(
      {required this.id,
      required this.userOne,
      required this.userTwo,
      required this.status,
      required this.createAt});

      /// * from json
      
   factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

      /// * to json
  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
