import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/network/use_case.dart';

import '../../../network/failure_entity.dart';

class DeleteLeadUseCase extends UseCase<Either<FailureEntity, void>, num> {
  final LeadRepository repository;

  DeleteLeadUseCase(this.repository);

  @override
  Future<Either<FailureEntity, void>> call(num params) async {
    return await repository.deleteLead(params);
  }
}
