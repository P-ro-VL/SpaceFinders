class UserEntity {
  final num? userId;
  final String? username;
  final String? password;
  final String? email;
  final String? phone;
  final String? fullName;
  final dynamic birthDate;
  final String? role;
  final String? avatar;
  final String? idCardNumber;
  final String? address;
  final String? bankInfo;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  UserEntity({
    this.userId,
    this.username,
    this.password,
    this.email,
    this.phone,
    this.fullName,
    this.birthDate,
    this.role,
    this.avatar,
    this.idCardNumber,
    this.address,
    this.bankInfo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
}
