import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/post_data_source.dart';
import 'package:spacefinder/data/model/post_model.dart';
import 'package:spacefinder/domain/entity/post_entity.dart';
import 'package:spacefinder/domain/repository/post_repository.dart';
import 'package:spacefinder/domain/usecase/post/create_post_use_case.dart';
import 'package:spacefinder/domain/usecase/post/get_post_use_case.dart';
import 'package:spacefinder/domain/usecase/post/update_post_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';

class PostRepositoryImpl extends PostRepository {
  final PostDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, bool>> createPost(
      CreatePostParams params) async {
    final response = await dataSource.createPost(params);
    return Either.cond(response != null, FetchFailure(), response!);
  }

  @override
  Future<Either<FailureEntity, PostEntity>> getPost(
      GetPostParams params) async {
    final response = await dataSource.getPostDetail(params);
    return Either.cond(response != null, FetchFailure(), response!.toEntity);
  }

  @override
  Future<Either<FailureEntity, bool>> updatePost(
      UpdatePostParams params) async {
    final response = await dataSource.updatePost(params);
    return Either.cond(response != null, FetchFailure(), response!);
  }
}
