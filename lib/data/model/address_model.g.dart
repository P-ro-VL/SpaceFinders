// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProvinceModelImpl _$$ProvinceModelImplFromJson(Map<String, dynamic> json) =>
    _$ProvinceModelImpl(
      name: json['name'] as String?,
      code: json['code'] as num?,
      codename: json['codename'] as String?,
      divisionType: json['division_type'] as String?,
      phoneCode: json['phone_code'] as num?,
      districts: (json['districts'] as List<dynamic>?)
          ?.map((e) => DistrictModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProvinceModelImplToJson(_$ProvinceModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'codename': instance.codename,
      'division_type': instance.divisionType,
      'phone_code': instance.phoneCode,
      'districts': instance.districts,
    };

_$DistrictModelImpl _$$DistrictModelImplFromJson(Map<String, dynamic> json) =>
    _$DistrictModelImpl(
      name: json['name'] as String?,
      code: json['code'] as num?,
      codename: json['codename'] as String?,
      divisionType: json['division_type'] as String?,
      shortCodename: json['short_codename'] as String?,
      wards: (json['wards'] as List<dynamic>?)
          ?.map((e) => WardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DistrictModelImplToJson(_$DistrictModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'codename': instance.codename,
      'division_type': instance.divisionType,
      'short_codename': instance.shortCodename,
      'wards': instance.wards,
    };

_$WardModelImpl _$$WardModelImplFromJson(Map<String, dynamic> json) =>
    _$WardModelImpl(
      name: json['name'] as String?,
      code: json['code'] as num?,
      codename: json['codename'] as String?,
      divisionType: json['division_type'] as String?,
      shortCodename: json['short_codename'] as String?,
    );

Map<String, dynamic> _$$WardModelImplToJson(_$WardModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'codename': instance.codename,
      'division_type': instance.divisionType,
      'short_codename': instance.shortCodename,
    };
