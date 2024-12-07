import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/data/datasource/address_data_source.dart';
import 'package:spacefinder/data/datasource/file_data_source.dart';
import 'package:spacefinder/data/datasource/lead_data_source.dart';
import 'package:spacefinder/data/repository/address_repository_impl.dart';
import 'package:spacefinder/data/repository/file_repository_impl.dart';
import 'package:spacefinder/data/repository/lead_repository_impl.dart';
import 'package:spacefinder/domain/usecase/address/get_districts_use_case.dart';
import 'package:spacefinder/domain/usecase/address/get_provinces_use_case.dart';
import 'package:spacefinder/domain/usecase/address/get_wards_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/create_lead_use_case.dart';
import 'package:spacefinder/domain/usecase/lead/upload_lead_images_use_case.dart';
import 'package:spacefinder/domain/usecase/upload_file_use_case.dart';
import 'package:spacefinder/network/use_case.dart';
import 'package:uuid/uuid.dart';

class CreateLeadLayoutController extends GetxController {
  final isNeedRentDemand = RxBool(true);
  final currentStep = RxInt(1);
  final isLoading = RxBool(true);

  final realEstateType = RxString('Đất nền');
  final rentType = RxString('Dài hạn');
  final expectedAddress = RxString('');
  final expectedPrice = RxString('');
  final priceUnit = RxString('VNĐ');
  final area = RxString('');
  final note = RxString('');
  final legalInfo = RxString('Sổ đỏ/Sổ hồng');
  final furniture = RxString('');
  String numOfBedrooms = '';
  String numOfBathrooms = '';
  final houseDirection = RxString('');
  final balconyDirection = RxString('');
  String mainRoadDist = '';
  String facadeWidth = '';
  final numOfRent = RxString('');
  final postTitle = RxString('');
  final postDescription = RxString('');

  final province = Rxn(Constants.default_province);
  final district = Rxn(Constants.default_district);
  final ward = Rxn(Constants.default_ward);

  int provinceId = 1, districtId = 1, wardId = 1;

  final street = RxString('');
  final address = RxString('');

  final realEstateTypes =
      RxList<String>(Constants.default_property_types.names);
  final rentTypes = RxList<String>(Constants.default_rental_types.names);
  final priceUnits = RxList<String>(['VNĐ', 'Thoả thuận']);
  final furnitures = RxList<String>(Constants.default_furnishing.names);
  final directions = RxList<String>(Constants.default_directions.names);
  final legalInfos = RxList<String>(Constants.default_legal_infos.names);

  final provinces = RxList<String>();
  final districts = RxList<String>();
  final wards = RxList<String>();

  final getProvincesUseCase =
      GetProvincesUseCase(AddressRepositoryImpl(AddressDataSourceImpl()));
  final getDistrictsUseCase =
      GetDistrictsUseCase(AddressRepositoryImpl(AddressDataSourceImpl()));
  final getWardsUseCase =
      GetWardsUseCase(AddressRepositoryImpl(AddressDataSourceImpl()));

  final uploadFileUseCase =
      UploadFileUseCase(FileRepositoryImpl(FileDataSourceImpl()));
  final uploadLeadImagesUseCase =
      UploadLeadImagesUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));

  final createLeadUseCase =
      CreateLeadUseCase(LeadRepositoryImpl(LeadDataSourceImpl()));

  final authenController = Get.find<AuthenticationController>();

  final images = [];
  String legalFile = '';

  @override
  void onInit() {
    prefill().then((_) {
      isLoading.value = false;
    });
    super.onInit();
  }

  Future<void> prefill() async {
    final province = await getProvincesUseCase.call(NoParams());
    province.fold((l) {}, (r) {
      provinces.assignAll(r.map((e) => e.name ?? '').toList());
    });

    await loadDistricts();
    await loadWards();
  }

  Future<void> loadDistricts() async {
    final districtValue = await getDistrictsUseCase.call(provinceId);
    districtValue.fold((l) {}, (r) {
      districts.assignAll(r.map((e) => e.name ?? '').toList());
      district.value = districts.first;
    });
  }

  Future<void> loadWards() async {
    final wardValue = await getWardsUseCase
        .call(GetWardsParams(provinceId: provinceId, districtId: districtId));
    wardValue.fold((l) {}, (r) {
      wards.assignAll(r.map((e) => e.name ?? '').toList());
      ward.value = wards.first;
    });
  }

  void upload(Uint8List bytes, {String type = 'image'}) async {
    final fileName = (Uuid().v4()) + (type == 'image' ? '.png' : '.pdf');
    final response = await uploadFileUseCase
        .call(UploadFileParams(bytes: bytes, fileName: fileName));
    response.fold((l) {}, (r) {
      if (type == 'image') {
        images.add(r);
      } else {
        legalFile = r;
      }
    });
  }

  Future<void> createPost({required isNeedRentDemand}) async {
    isLoading.value = false;

    final params = CreateLeadParams(
      uploadedBy: authenController.user.value?.userId,
      title: postTitle.value,
      description: postDescription.value,
      propertyType: realEstateType.value,
      rentalType: rentType.value,
      area: num.tryParse(area.value),
      price: priceUnit.value == 'Thoả thuận'
          ? -1
          : num.tryParse(expectedPrice.value.replaceAll(',', '')),
      city: province.value,
      district: district.value,
      ward: ward.value,
      street: isNeedRentDemand ? expectedAddress.value : street.value,
      requirements: note.value,
      numBathrooms: num.tryParse(numOfBathrooms),
      numBedrooms: num.tryParse(numOfBedrooms),
      houseDirection: houseDirection.value,
      balconyDirection: balconyDirection.value,
      furnishing: furniture.value,
      frontWidth: num.tryParse(facadeWidth),
      entranceWidth: num.tryParse(mainRoadDist),
      status: authenController.user.value?.role == 'CUSTOMER'
          ? 'PENDING'
          : 'APPROVED',
      reviewNote: null,
      reviewedBy: null,
      isDesired: isNeedRentDemand,
      legalStatus: legalInfo.value,
      code: LeadCommon.generateLeadCode(
          rentalType: rentType.value,
          propertyType: realEstateType.value,
          isDesired: isNeedRentDemand),
    );
    final result = await createLeadUseCase.call(params);
    result.fold((l) {}, (r) async {
      await uploadLeadImagesUseCase.call(UploadLeadImagesParams(
          leadId: r.leadId ?? -1, images: images.cast<String>()));
    });
    isLoading.value = true;
  }
}
