import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/usecase/get_user_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';

abstract class AuthenRepository {
  Future<Either<FailureEntity, UserEntity>> getUser(GetUserParams params);
}
