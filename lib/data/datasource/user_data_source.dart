import 'package:spacefinder/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserDataSource {
  Future<UserModel?> getUserDetail(num? userId);
}

class UserDataSourceImpl extends UserDataSource {
  final client = Supabase.instance.client;

  @override
  Future<UserModel?> getUserDetail(num? userId) async {
    final response =
        await client.from('users').select().eq('user_id', userId ?? -1);
    if (response.firstOrNull == null) return null;
    return UserModel.fromJson(response.first);
  }
}
