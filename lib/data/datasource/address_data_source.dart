import 'package:get/get.dart';
import 'package:spacefinder/constants.dart';

import '../model/address_model.dart';

abstract class AddressDataSource {
  Future<List<ProvinceModel>?> getProvinces();

  Future<List<DistrictModel>?> getDistricts(num? provinceId);

  Future<List<WardModel>?> getWards(num? provinceId, num? districtId);
}

class AddressDataSourceImpl extends AddressDataSource {
  @override
  Future<List<DistrictModel>?> getDistricts(num? provinceId) async {
    final districts = (await getProvinces())!
        .firstWhereOrNull((e) => e.code == provinceId)
        ?.districts;
    return districts;
  }

  @override
  Future<List<ProvinceModel>?> getProvinces() async {
    return Constants.addresses;
  }

  @override
  Future<List<WardModel>?> getWards(num? provinceId, num? districtId) async {
    final wards = (await getDistricts(provinceId))
        ?.firstWhereOrNull((e) => e.code == districtId)
        ?.wards;
    return wards;
  }
}
