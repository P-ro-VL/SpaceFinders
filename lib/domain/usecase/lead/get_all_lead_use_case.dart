import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../entity/lead_entity.dart';

class GetAllLeadUseCase
    extends UseCase<Either<FailureEntity, List<LeadEntity>>, GetAllLeadParams> {
  final LeadRepository repository;

  GetAllLeadUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<LeadEntity>>> call(
      GetAllLeadParams params) async {
    final allLeads = await repository.getAllLeads(params);
    return allLeads;
  }
}

class GetAllLeadParams {
  final String? province;
  final String? district;
  final List<String>? status;
  final String? realEstateType;
  final String? rentalType;
  final bool? isDesired;
  final num? minPrice;
  final num? maxPrice;
  final num? minArea;
  final num? maxArea;
  final num? uploadedBy;
  final String? propertyCodeKeyword;

  GetAllLeadParams({
    this.status,
    this.realEstateType,
    this.rentalType,
    this.isDesired,
    this.maxPrice,
    this.minPrice,
    this.province,
    this.district,
    this.uploadedBy,
    this.minArea,
    this.maxArea,
    this.propertyCodeKeyword,
  });
}
