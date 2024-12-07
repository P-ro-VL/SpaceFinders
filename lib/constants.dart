import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:spacefinder/common.dart';
import 'package:spacefinder/data/model/address_model.dart';

class Constants {
  static const String table_users = 'users';
  static const String table_posts = 'content_posts';
  static const String table_lead = 'lead_listings';

  static final List<ChoiceItem> default_directions = [
    ChoiceItem(code: 'NORTH', name: 'Bắc'),
    ChoiceItem(code: 'EAST', name: 'Đông'),
    ChoiceItem(code: 'SOUTH', name: 'Nam'),
    ChoiceItem(code: 'WEST', name: 'Tây'),
    ChoiceItem(code: 'NORTH_EAST', name: 'Đông Bắc'),
    ChoiceItem(code: 'SOUTH_EAST', name: 'Đông Nam'),
    ChoiceItem(code: 'SOUTH_WEST', name: 'Tây Nam'),
    ChoiceItem(code: 'NORTH_WEST', name: 'Tây Bắc'),
    ChoiceItem(code: 'UNKNOWN', name: ''),
  ];

  static final List<ChoiceItem> default_property_types = [
    ChoiceItem(code: 'VACANT_LAND', name: 'Đất nền'),
    ChoiceItem(code: 'APARTMENT', name: 'Chung cư'),
    ChoiceItem(code: 'OFFICE', name: 'Văn phòng'),
    ChoiceItem(code: 'SHOP', name: 'Cửa hàng'),
    ChoiceItem(code: 'MOTEL', name: 'Nhà trọ'),
  ];

  static final List<ChoiceItem> default_rental_types = [
    ChoiceItem(code: 'LONG_TERM', name: 'Dài hạn'),
    ChoiceItem(code: 'SHORT_TERM_BY_NIGHT', name: 'Ngắn hạn theo đêm'),
  ];

  static final List<ChoiceItem> default_furnishing = [
    ChoiceItem(code: 'BASIC', name: 'Cơ bản'),
    ChoiceItem(code: 'FULL', name: 'Đầy đủ'),
    ChoiceItem(code: 'EMPTY', name: 'Không nội thất'),
    ChoiceItem(code: 'UNKNOWN', name: ''),
  ];

  static final List<ChoiceItem> default_legal_infos = [
    ChoiceItem(code: 'CERTIFICATE', name: 'Sổ đỏ/Sổ hồng'),
    ChoiceItem(code: 'CONTRACT', name: 'Hợp đồng mua bán'),
  ];

  static final List<ChoiceItem> default_contract_statuses = [
    ChoiceItem(code: 'PENDING', name: 'Đang xử lý'),
    ChoiceItem(code: 'COMPLETED', name: 'Đã hoàn thành'),
  ];

  static final List<ChoiceItem> default_request_types = [
    ChoiceItem(code: 'REMOVE', name: 'Gỡ'),
    ChoiceItem(code: 'EXTEND', name: 'Gia hạn'),
  ];

  static const String default_province = 'Thành phố Hà Nội';
  static const num default_province_id = 1;
  static const String default_district = 'Quận Ba Đình';
  static const num default_district_id = 1;
  static const String default_ward = 'Phường Phúc Xá';
  static const num default_ward_id = 1;

  static final List<ProvinceModel> addresses = [];

  static void initAddresses() async {
    final rawData = await rootBundle.loadString('assets/address.json');
    final address = jsonDecode(rawData).cast<Map<String, dynamic>>();
    for (final province in address) {
      addresses.add(ProvinceModel.fromJson(province));
    }
  }

  static num getProvinceId(String provinceName) {
    for (final province in addresses) {
      if (province.name == provinceName) return province.code!;
    }
    return -1;
  }

  static num getDistrictId(num provinceId, String districtName) {
    for (final province in addresses) {
      if (province.code == provinceId) {
        for (final district in province.districts ?? []) {
          if (district.name == districtName) return district.code!;
        }
      }
    }
    return -1;
  }
}

extension EntryExtension on List<ChoiceItem> {
  List<String> get codes => map((e) => e.code ?? '').toSet().toList();
  List<String> get names => map((e) => e.name ?? '').toSet().toList();
}
