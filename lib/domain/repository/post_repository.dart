import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/post_entity.dart';
import 'package:spacefinder/domain/usecase/post/create_post_use_case.dart';
import 'package:spacefinder/domain/usecase/post/get_post_use_case.dart';
import 'package:spacefinder/domain/usecase/post/update_post_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';

abstract class PostRepository {
  Future<Either<FailureEntity, PostEntity>> getPost(GetPostParams params);
  Future<Either<FailureEntity, bool>> createPost(CreatePostParams params);
  Future<Either<FailureEntity, bool>> updatePost(UpdatePostParams params);
}
