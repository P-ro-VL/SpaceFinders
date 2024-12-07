import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/address_entity.dart';
import 'package:spacefinder/network/failure_entity.dart';

abstract class AddressRepository {
  Future<Either<FailureEntity, List<ProvinceEntity>>> getProvinces();

  Future<Either<FailureEntity, List<DistrictEntity>>> getDistricts(
      num? provinceId);

  Future<Either<FailureEntity, List<WardEntity>>> getWards(
      num? provinceId, num? districtId);
}
