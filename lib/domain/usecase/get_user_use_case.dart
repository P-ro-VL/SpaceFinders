import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/domain/repository/authen_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class GetUserUseCase
    extends UseCase<Either<FailureEntity, UserEntity>, GetUserParams> {
  final AuthenRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<FailureEntity, UserEntity>> call(GetUserParams params) async {
    return await repository.getUser(params);
  }
}

class GetUserParams {
  final String? username;
  final String? password;

  GetUserParams({this.username, this.password});
}
