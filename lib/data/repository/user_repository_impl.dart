import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/user_data_source.dart';
import 'package:spacefinder/data/model/user_model.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/domain/repository/user_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, UserEntity>> getUserDetail(num? userId) async {
    final response = await dataSource.getUserDetail(userId);
    return Either.cond(response != null, FailureEntity(), response!.toEntity);
  }
}
