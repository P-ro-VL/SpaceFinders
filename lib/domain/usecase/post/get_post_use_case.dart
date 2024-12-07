import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/post_entity.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class GetPostUseCase
    extends UseCase<Either<FailureEntity, PostEntity>, GetPostParams> {
  @override
  Future<Either<FailureEntity, PostEntity>> call(GetPostParams params) {
    throw UnimplementedError();
  }
}

class GetPostParams {
  final num? postId;

  GetPostParams({
    this.postId,
  });
}
