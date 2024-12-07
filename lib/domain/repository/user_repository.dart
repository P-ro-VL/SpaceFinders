import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/network/failure_entity.dart';

abstract class UserRepository {
  Future<Either<FailureEntity, UserEntity>> getUserDetail(num? userId);
}
