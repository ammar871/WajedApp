
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.g.dart';
//dart run build_runner build
@JsonSerializable()
class MessageModel {
  final int id;
  final int convId;
  final int type;
  final String? text;
  final String? senderId;
  final String? receiverId;
  final int status;
  final bool isReading;
  final String createdAt;

  MessageModel(
      {required this.id,
      required this.convId,
      required this.type,
      required this.text,
      required this.senderId,
      required this.receiverId,
      required this.status,
      required this.isReading,
      required this.createdAt});

      /// * from json
      
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  /// * to json
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
      

}
