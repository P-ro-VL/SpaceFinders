import 'package:spacefinder/constants.dart';
import 'package:spacefinder/data/model/user_model.dart';
import 'package:spacefinder/domain/usecase/get_user_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenDataSource {
  Future<UserModel?> getUser(GetUserParams params);
}

class AuthenDataSourceImpl extends AuthenDataSource {
  SupabaseClient get client => Supabase.instance.client;

  @override
  Future<UserModel?> getUser(GetUserParams params) async {
    final response = await client
        .from(Constants.table_users)
        .select()
        .eq('username', params.username ?? '')
        .eq('password', params.password ?? '');
    if (response.firstOrNull == null) return null;
    return UserModel.fromJson(response.first);
  }
}
