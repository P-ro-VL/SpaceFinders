import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/domain/usecase/lead/get_lead_images_use_case.dart';

import '../../domain/entity/lead_entity.dart';

class DetailLeadManagementPopupController extends GetxController {
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final areaController = TextEditingController();
  final noteController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final numOfBedroomController = TextEditingController();
  final numOfBathroomController = TextEditingController();
  final mainRoadDistController = TextEditingController();
  final facadeWidthController = TextEditingController();
  final leadCodeController = TextEditingController();

  final legalInfo = RxString('Sổ đỏ/Sổ hồng');

  final realEstateType = RxString('');
  final rentType = RxString('');
  final priceUnit = RxString('');
  final furniture = RxString('');
  final housingDirection = RxString('');
  final balconyDirection = RxString('');

  final getLeadImagesUseCase =
      GetLeadImagesUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));
  final images = RxList();

  final lead = Rxn<LeadEntity>();

  final isLoading = RxBool(true);

  String proof = '';

  void prefill() async {
    isLoading.value = true;

    images.value =
        (await getLeadImagesUseCase.call(lead.value?.leadId ?? -1)).right;

    addressController.text = lead.value?.street ?? '';
    priceController.text = (lead.value?.price?.toString() == '-1')
        ? 'Thoả thuận'
        : (lead.value?.price?.toString() ?? '');
    areaController.text = lead.value?.area?.toString() ?? '';
    noteController.text = lead.value?.requirements ?? '';
    titleController.text = lead.value?.title ?? '';
    descriptionController.text = lead.value?.description ?? '';
    numOfBedroomController.text = lead.value?.numBedrooms?.toString() ?? '';
    numOfBathroomController.text = lead.value?.numBathrooms?.toString() ?? '';
    mainRoadDistController.text = lead.value?.entranceWidth?.toString() ?? '';
    facadeWidthController.text = lead.value?.frontWidth?.toString() ?? '';
    leadCodeController.text = lead.value?.code ?? '';

    realEstateType.value = lead.value?.propertyType ?? '';
    rentType.value = lead.value?.rentalType ?? '';
    priceUnit.value = 'VNĐ';
    furniture.value = lead.value?.furnishing ?? '';
    housingDirection.value = lead.value?.houseDirection ?? '';
    balconyDirection.value = lead.value?.balconyDirection ?? '';

    proof = lead.value?.legalDocuments ?? '';
    legalInfo.value = lead.value?.legalStatus ?? '';

    isLoading.value = false;
  }
}
