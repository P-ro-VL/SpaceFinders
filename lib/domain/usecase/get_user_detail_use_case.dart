import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/domain/repository/user_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class GetUserDetailUseCase
    extends UseCase<Either<FailureEntity, UserEntity>, num> {
  final UserRepository repository;

  GetUserDetailUseCase(this.repository);

  @override
  Future<Either<FailureEntity, UserEntity>> call(num params) async {
    return await repository.getUserDetail(params);
  }
}
