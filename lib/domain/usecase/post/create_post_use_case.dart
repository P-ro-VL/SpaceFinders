import 'package:either_dart/either.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class CreatePostUseCase
    extends UseCase<Either<FailureEntity, bool>, CreatePostParams> {
  @override
  Future<Either<FailureEntity, bool>> call(CreatePostParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class CreatePostParams {
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
