import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/data/datasource/contract_data_source.dart';
import 'package:spacefinder/data/datasource/file_data_source.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/repository/contract_repository_impl.dart';
import 'package:spacefinder/data/repository/file_repository_impl.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/domain/usecase/contract/create_contract_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/get_all_lead_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/update_lead_use_case.dart';
import 'package:spacefinder/domain/usecase/upload_file_use_case.dart';
import 'package:uuid/v4.dart';

class CreateContractPageController extends GetxController {
  final getAllLeadUseCase =
      GetAllLeadUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));
  final createContractUseCase =
      CreateContractUseCase(ContractRepositoryImpl(ContractDataSourceImpl()));
  final updateLeadUseCase =
      UpdateLeadUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));
  final uploadFileUseCase =
      UploadFileUseCase(FileRepositoryImpl(FileDataSourceImpl()));

  final isLoading = RxBool(false);

  final price = RxString('');
  final deposit = RxString('');
  final propertyCode = RxString('');
  final rentalType = RxString('Dài hạn');
  final status = RxString('Đang xử lý');

  final signedDate = Rxn<DateTime>();
  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();

  Uint8List? bytes;

  Future<void> createContract() async {
    isLoading.value = true;
    final file = await uploadFileUseCase.call(UploadFileParams(
        bytes: bytes, fileName: '${const UuidV4().generate()}.pdf'));

    final leads = (await getAllLeadUseCase
            .call(GetAllLeadParams(propertyCodeKeyword: propertyCode.value)))
        .right;
    final lead = leads.firstWhereOrNull((e) => e.code == propertyCode.value);

    final authController = Get.find<AuthenticationController>();
    final params = CreateContractParams(
      salesId: authController.user.value?.userId ?? -1,
      leadId: lead?.leadId ?? -1,
      propertyCode: propertyCode.value,
      price: int.tryParse(price.value) ?? 0,
      status: status.value,
      depositAmount: int.tryParse(deposit.value) ?? 0,
      signedDate: signedDate.value?.millisecondsSinceEpoch ?? 0,
      startDate: startDate.value?.millisecondsSinceEpoch ?? 0,
      endDate: endDate.value?.millisecondsSinceEpoch ?? 0,
      url: file.right,
    );

    await createContractUseCase.call(params);

    String leadStatus = DateTime.now()
            .isAfter(startDate.value ?? DateTime.fromMillisecondsSinceEpoch(0))
        ? 'RENTED'
        : 'APPROVED';
    if (DateTime.now()
        .isAfter(endDate.value ?? DateTime.fromMillisecondsSinceEpoch(0))) {
      leadStatus = 'CLOSED';
    }

    await updateLeadUseCase
        .call(UpdateLeadParams(lead?.leadId, status: leadStatus));

    isLoading.value = false;
  }
}
