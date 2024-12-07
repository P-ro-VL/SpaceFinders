import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/network/failure_entity.dart';

import '../usecase/lead/create_lead_use_case.dart';
import '../usecase/lead/get_all_lead_use_case.dart';
import '../usecase/lead/update_lead_use_case.dart';

abstract class LeadRepository {
  Future<Either<FailureEntity, LeadEntity>> getLead(num? leadId);
  Future<Either<FailureEntity, LeadEntity>> createLead(CreateLeadParams params);
  Future<Either<FailureEntity, bool>> updateLead(UpdateLeadParams params);

  Future<Either<FailureEntity, List<LeadEntity>>> getAllLeads(
      GetAllLeadParams params);

  Future<void> uploadLeadImages(num leadId, List<String> images);
  Future<Either<FailureEntity, List<String>>> getLeadImages(num leadId);
}
