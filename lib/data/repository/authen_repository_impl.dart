import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/authen_data_source.dart';
import 'package:spacefinder/data/model/user_model.dart';
import 'package:spacefinder/domain/usecase/get_user_use_case.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/domain/repository/authen_repository.dart';

class AuthenRepositoryImpl extends AuthenRepository {
  final AuthenDataSource dataSource;

  AuthenRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, UserEntity>> getUser(
      GetUserParams params) async {
    final response = await dataSource.getUser(params);
    final result =
        Either.cond(response != null, FetchFailure(), response!.toEntity);
    return result;
  }
}
