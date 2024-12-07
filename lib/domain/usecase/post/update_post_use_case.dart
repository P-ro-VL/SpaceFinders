import 'package:either_dart/either.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class UpdatePostUseCase
    extends UseCase<Either<FailureEntity, bool>, UpdatePostParams> {
  @override
  Future<Either<FailureEntity, bool>> call(UpdatePostParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class UpdatePostParams {
  final num? postId;

  UpdatePostParams({this.postId});

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
