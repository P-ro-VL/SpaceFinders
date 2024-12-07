import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class GetLeadImagesUseCase
    extends UseCase<Either<FailureEntity, List<String>>, num> {
  final LeadRepository repository;

  GetLeadImagesUseCase(this.repository);

  @override
  Future<Either<FailureEntity, List<String>>> call(num params) async {
    return await repository.getLeadImages(params);
  }
}
