import 'package:spacefinder/constants.dart';
import 'package:spacefinder/domain/usecase/post/get_post_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/usecase/post/create_post_use_case.dart';
import '../../domain/usecase/post/update_post_use_case.dart';
import '../model/post_model.dart';

abstract class PostDataSource {
  Future<PostModel?> getPostDetail(GetPostParams params);
  Future<bool?> createPost(CreatePostParams params);
  Future<bool?> updatePost(UpdatePostParams params);
}

class PostDataSourceImpl extends PostDataSource {
  SupabaseClient get client => Supabase.instance.client;

  @override
  Future<bool?> createPost(CreatePostParams params) async {
    try {
      await client.from(Constants.table_posts).insert(params.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<PostModel?> getPostDetail(GetPostParams params) async {
    final result = await client
        .from(Constants.table_posts)
        .select()
        .eq('post_id', params.postId ?? -1);
    if (result.firstOrNull == null) return null;
    return PostModel.fromJson(result.first);
  }

  @override
  Future<bool?> updatePost(UpdatePostParams params) async {
    try {
      await client
          .from(Constants.table_posts)
          .update(params.toJson())
          .eq('post_id', params.postId ?? -1);
      return true;
    } catch (_) {
      return false;
    }
  }
}
