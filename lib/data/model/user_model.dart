import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory UserModel(
      {num? userId,
      String? username,
      String? password,
      String? email,
      String? phone,
      String? fullName,
      dynamic birthDate,
      String? role,
      String? avatar,
      String? idCardNumber,
      String? address,
      String? bankInfo,
      String? status,
      dynamic createdAt,
      dynamic updatedAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelExts on UserModel {
  UserEntity get toEntity => UserEntity(
        userId: userId,
        username: username,
        password: password,
        email: email,
        phone: phone,
        fullName: fullName,
        birthDate: birthDate,
        role: role,
        avatar: avatar,
        idCardNumber: idCardNumber,
        address: address,
        bankInfo: bankInfo,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
