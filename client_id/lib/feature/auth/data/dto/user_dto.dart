import 'package:client_id/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final dynamic id;
  final dynamic username;
  final dynamic email;
  final dynamic refreshToken;
  final dynamic accessToken;

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.refreshToken,
    required this.accessToken,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id.toString(),
      username: username.toString(),
      email: email.toString(),
      refreshToken: refreshToken.toString(),
      accessToken: accessToken.toString(),
    );
  }
}
