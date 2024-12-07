// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['user_id'] as num?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      fullName: json['full_name'] as String?,
      birthDate: json['birth_date'],
      role: json['role'] as String?,
      avatar: json['avatar'] as String?,
      idCardNumber: json['id_card_number'] as String?,
      address: json['address'] as String?,
      bankInfo: json['bank_info'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'phone': instance.phone,
      'full_name': instance.fullName,
      'birth_date': instance.birthDate,
      'role': instance.role,
      'avatar': instance.avatar,
      'id_card_number': instance.idCardNumber,
      'address': instance.address,
      'bank_info': instance.bankInfo,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
