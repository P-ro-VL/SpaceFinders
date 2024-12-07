import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/address_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../entity/address_entity.dart';

class GetWardsUseCase
    extends UseCase<Either<FailureEntity, List<WardEntity>>, GetWardsParams> {
  final AddressRepository repository;

  GetWardsUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<WardEntity>>> call(
      GetWardsParams params) async {
    return await repository.getWards(params.provinceId, params.districtId);
  }
}

class GetWardsParams {
  final num? provinceId;
  final num? districtId;

  GetWardsParams({this.provinceId, this.districtId});
}
