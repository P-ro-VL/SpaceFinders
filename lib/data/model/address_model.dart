import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacefinder/domain/entity/address_entity.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class ProvinceModel with _$ProvinceModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory ProvinceModel({
    String? name,
    num? code,
    String? codename,
    String? divisionType,
    num? phoneCode,
    List<DistrictModel>? districts,
  }) = _ProvinceModel;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);
}

@freezed
class DistrictModel with _$DistrictModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DistrictModel({
    String? name,
    num? code,
    String? codename,
    String? divisionType,
    String? shortCodename,
    List<WardModel>? wards,
  }) = _DistrictModel;

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);
}

@freezed
class WardModel with _$WardModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory WardModel({
    String? name,
    num? code,
    String? codename,
    String? divisionType,
    String? shortCodename,
  }) = _WardModel;

  factory WardModel.fromJson(Map<String, dynamic> json) =>
      _$WardModelFromJson(json);
}

extension ProvinceModelExts on ProvinceModel {
  ProvinceEntity get toEntity => ProvinceEntity(
        name: name,
        id: code,
        codeName: codename,
        divisionType: divisionType,
        phoneCode: phoneCode,
        districts: districts?.map((e) => e.toEntity).toList(),
      );
}

extension DistrictModelExts on DistrictModel {
  DistrictEntity get toEntity => DistrictEntity(
        name: name,
        id: code,
        codeName: codename,
        divisionType: divisionType,
        shortCodename: shortCodename,
        wards: wards?.map((e) => e.toEntity).toList(),
      );
}

extension WardModelExts on WardModel {
  WardEntity get toEntity => WardEntity(
      name: name,
      id: code,
      codeName: codename,
      divisionType: divisionType,
      shortCodename: shortCodename);
}
