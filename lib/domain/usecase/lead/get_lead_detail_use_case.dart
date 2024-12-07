import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class GetLeadDetailUseCase
    extends UseCase<Either<FailureEntity, LeadEntity>, num> {
  final LeadRepository repository;

  GetLeadDetailUseCase(this.repository);

  @override
  Future<Either<FailureEntity, LeadEntity>> call(num params) async {
    return await repository.getLead(params);
  }
}