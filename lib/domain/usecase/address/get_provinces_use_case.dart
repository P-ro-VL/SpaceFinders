import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/address_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../entity/address_entity.dart';

class GetProvincesUseCase
    extends UseCase<Either<FailureEntity, List<ProvinceEntity>>, NoParams> {
  final AddressRepository repository;

  GetProvincesUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<ProvinceEntity>>> call(
      NoParams params) async {
    return await repository.getProvinces();
  }
}
