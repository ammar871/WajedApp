
import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_fav_body.g.dart';
@JsonSerializable()
class AddFavBody{
    final String? userId;
  final int marketId;

  AddFavBody(this.userId, this.marketId);

  Map<String, dynamic> toJson() => _$AddFavBodyToJson(this);
}