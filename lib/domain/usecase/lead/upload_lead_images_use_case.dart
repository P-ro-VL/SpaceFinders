import 'package:spacefinder/domain/repository/lead_repository.dart';

import '../../../network/use_case.dart';

class UploadLeadImagesUseCase extends UseCase<void, UploadLeadImagesParams> {
  final LeadRepository repository;

  UploadLeadImagesUseCase(this.repository);

  @override
  Future<void> call(UploadLeadImagesParams params) async {
    return repository.uploadLeadImages(params.leadId, params.images);
  }
}

class UploadLeadImagesParams {
  final num leadId;
  final List<String> images;

  UploadLeadImagesParams({
    required this.leadId,
    required this.images,
  });
}
