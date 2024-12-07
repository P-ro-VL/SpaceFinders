import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/address_data_source.dart';
import 'package:spacefinder/data/model/address_model.dart';

import 'package:spacefinder/domain/entity/address_entity.dart';

import 'package:spacefinder/network/failure_entity.dart';

import '../../domain/repository/address_repository.dart';

class AddressRepositoryImpl extends AddressRepository {
  final AddressDataSource dataSource;

  AddressRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, List<DistrictEntity>>> getDistricts(
      num? provinceId) async {
    final result = await dataSource.getDistricts(provinceId);
    return Either.cond(result != null, FetchFailure(),
        result!.map((e) => e.toEntity).toList());
  }

  @override
  Future<Either<FailureEntity, List<ProvinceEntity>>> getProvinces() async {
    final result = await dataSource.getProvinces();
    return Either.cond(result != null, FetchFailure(),
        result!.map((e) => e.toEntity).toList());
  }

  @override
  Future<Either<FailureEntity, List<WardEntity>>> getWards(
      num? provinceId, num? districtId) async {
    final result = await dataSource.getWards(provinceId, districtId);
    return Either.cond(result != null, FailureEntity(),
        result!.map((e) => e.toEntity).toList());
  }
}
