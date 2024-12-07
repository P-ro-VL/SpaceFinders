import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/data/datasource/file_data_source.dart';
import 'package:spacefinder/data/datasource/request_data_source.dart';
import 'package:spacefinder/data/repository/file_repository_impl.dart';
import 'package:spacefinder/data/repository/request_repository_impl.dart';
import 'package:spacefinder/domain/usecase/request/create_request_use_case.dart';
import 'package:spacefinder/domain/usecase/upload_file_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/v4.dart';

import '../lead/history/lead_history_page_c.dart';

class CreateRequestPopupController extends GetxController {
  final postCode = RxString('');
  final selectedRequestType = RxString('Gia hạn');
  final description = RxString('');

  final leadOptions = RxList<String>();
  final selectedLeadOption = RxString('');

  Uint8List? selectedFile;
  num? leadId;

  final createRequestUseCase =
      CreateRequestUseCase(RequestRepositoryImpl(RequestDataSourceImpl()));
  final uploadFileUseCase =
      UploadFileUseCase(FileRepositoryImpl(FileDataSourceImpl()));

  @override
  void onInit() {
    final historyController = Get.find<LeadHistoryPageController>();
    leadOptions.assignAll(historyController.leads
        .map((e) => "${e.code ?? '--'} - ${e.title ?? '--'}"));
    selectedLeadOption.value = leadOptions.first;
    super.onInit();
  }

  Future<bool> createRequest() async {
    final authController = Get.find<AuthenticationController>();

    final uploadResponse = await uploadFileUseCase.call(UploadFileParams(
        bytes: selectedFile, fileName: '${const UuidV4().generate()}.png'));

    final params = CreateRequestParams(
      userId: authController.user.value?.userId,
      leadId: leadId,
      requestType: selectedRequestType.value,
      requestDetails: description.value,
      status: 'PENDING',
      evidenceFile: Supabase.instance.client.storage
          .from('spacefinder-cdn')
          .getPublicUrl(
              uploadResponse.right.replaceAll("spacefinder-cdn/", "")),
    );
    final response = await createRequestUseCase.call(params);
    return response.fold((l) {
      return false;
    }, (r) {
      return true;
    });
  }
}
