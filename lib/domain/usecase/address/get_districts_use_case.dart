import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/address_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../entity/address_entity.dart';

class GetDistrictsUseCase
    extends UseCase<Either<FailureEntity, List<DistrictEntity>>, num?> {
  final AddressRepository repository;

  GetDistrictsUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<DistrictEntity>>> call(num? params) async {
    return await repository.getDistricts(params);
  }
}
