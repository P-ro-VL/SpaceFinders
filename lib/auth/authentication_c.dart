import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/data/datasource/authen_data_source.dart';
import 'package:spacefinder/data/repository/authen_repository_impl.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/domain/usecase/get_user_use_case.dart';

class AuthenticationController extends GetxController {
  final getUserUseCase =
      GetUserUseCase(AuthenRepositoryImpl(AuthenDataSourceImpl()));

  final username = RxString('');
  final password = RxString('');

  final user = Rxn<UserEntity>();

  Future<void> logOut() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();

    username.value = '';
    password.value = '';

    user.value = null;
  }

  Future<bool> fetchUserFromStorage() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    int userId = sharedPrefs.getInt('userId') ?? -1;
    if (userId == -1) return false;
    String username = sharedPrefs.getString('username') ?? '';
    String password = sharedPrefs.getString('password') ?? '';
    String email = sharedPrefs.getString('email') ?? '';
    String phone = sharedPrefs.getString('phone') ?? '';
    String fullName = sharedPrefs.getString('fullName') ?? '';
    int birthDate = sharedPrefs.getInt('birthDate') ?? -1;
    String role = sharedPrefs.getString('role') ?? '';
    String avatar = sharedPrefs.getString('avatar') ?? '';
    String idCardNumber = sharedPrefs.getString('idCardNumber') ?? '';
    String address = sharedPrefs.getString('address') ?? '';
    String bankInfo = sharedPrefs.getString('bankInfo') ?? '';
    String status = sharedPrefs.getString('status') ?? '';
    int createdAt = sharedPrefs.getInt('createdAt') ?? -1;
    int updatedAt = sharedPrefs.getInt('updatedAt') ?? -1;

    final userEntity = UserEntity(
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
    user.value = userEntity;
    return true;
  }

  Future<bool> fetchUser() async {
    final response = await getUserUseCase.call(
        GetUserParams(username: username.value, password: password.value));
    final result = response.fold((l) async {
      SnackbarCommon.showErrorSnackbar(errorMessage: l.message);
      return false;
    }, (r) async {
      user.value = r;

      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setInt('userId', r.userId?.toInt() ?? -1);
      sharedPrefs.setString('username', r.username ?? '');
      sharedPrefs.setString('password', r.password ?? '');
      sharedPrefs.setString('email', r.email ?? '');
      sharedPrefs.setString('phone', r.phone ?? '');
      sharedPrefs.setString('fullName', r.fullName ?? '');
      sharedPrefs.setInt('birthDate', r.birthDate ?? 0);
      sharedPrefs.setString('role', r.role ?? '');
      sharedPrefs.setString('avatar', r.avatar ?? '');
      sharedPrefs.setString('idCardNumber', r.idCardNumber ?? '');
      sharedPrefs.setString('address', r.address ?? '');
      sharedPrefs.setString('bankInfo', r.bankInfo ?? '');
      sharedPrefs.setString('status', r.status ?? '');
      sharedPrefs.setInt('createdAt', r.createdAt ?? 0);
      sharedPrefs.setInt('updatedAt', r.updatedAt ?? 0);
      return true;
    });
    return await result;
  }
}
