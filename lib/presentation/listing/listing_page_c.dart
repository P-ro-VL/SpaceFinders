import 'package:get/get.dart';
import 'package:spacefinder/constants.dart';

import '../../data/datasource/address_data_source.dart';
import '../../data/datasource/lead_data_source.dart';
import '../../data/repository/address_repository_impl.dart';
import '../../data/repository/lead_repository_impl.dart';
import '../../domain/entity/lead_entity.dart';
import '../../domain/usecase/address/get_districts_use_case.dart';
import '../../domain/usecase/address/get_provinces_use_case.dart';
import '../../domain/usecase/lead/get_all_lead_use_case.dart';
import '../../network/use_case.dart';

class LeadListingPageController extends GetxController {
  LeadListingPageController(bool isDemand) {
    isNeedRentDemand.value = isDemand;
  }

  final repository = LeadRepositoryImpl(LeadDataSourceImpl());

  late GetAllLeadUseCase getAllLeadUseCase = GetAllLeadUseCase(repository);
  final getProvincesUseCase =
      GetProvincesUseCase(AddressRepositoryImpl(AddressDataSourceImpl()));
  final getDistrictsUseCase =
      GetDistrictsUseCase(AddressRepositoryImpl(AddressDataSourceImpl()));

  final isLoading = RxBool(false);

  final minPrice = RxDouble(1000000);
  final maxPrice = RxDouble(50000000);

  final isNeedRentDemand = Rxn<bool>();
  final rentalType = Rxn<String>();
  final propertyType = Rxn<String>('All');

  final province = RxString(Constants.default_province);
  final district = RxString('All');

  final provinces = RxList<String>();
  final districts = RxList<String>();

  num provinceId = Constants.default_province_id;
  num districtId = 1;

  final leads = RxList<LeadEntity>();

  @override
  void onInit() {
    fetchData(init: true);
    super.onInit();
  }

  Future<void> fetchData({bool init = false}) async {
    isLoading.value = true;
    final params = GetAllLeadParams(
      isDesired: isNeedRentDemand.value,
      status: ['APPROVED', 'RENTED'],
      rentalType: rentalType.value,
      realEstateType: propertyType.value == 'All' ? null : propertyType.value,
      province: province.value,
      district: district.value == 'All' ? null : district.value,
      maxPrice: maxPrice.value == 50000000 ? null : maxPrice.value,
      minPrice: minPrice.value == 1000000 ? null : minPrice.value,
    );
    final response = await getAllLeadUseCase.call(params);
    response.fold((l) {}, (r) {
      leads.assignAll(r);
      if (init || provinces.isEmpty) prefill();
      isLoading.value = false;
    });
  }

  Future<void> prefill() async {
    final province = await getProvincesUseCase.call(NoParams());
    province.fold((l) {}, (r) {
      provinces.assignAll(r.map((e) => e.name ?? '').toList());
    });

    await loadDistricts();
  }

  Future<void> loadDistricts() async {
    final districtValue = await getDistrictsUseCase.call(provinceId);
    districtValue.fold((l) {}, (r) {
      districts.assignAll(r.map((e) => e.name ?? '').toList());
    });
  }
}
