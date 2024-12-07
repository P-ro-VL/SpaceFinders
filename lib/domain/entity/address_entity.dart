class ProvinceEntity {
  final String? name;
  final num? id;
  final String? codeName;
  final String? divisionType;
  final num? phoneCode;
  final List<DistrictEntity>? districts;

  ProvinceEntity({
    this.name,
    this.id,
    this.codeName,
    this.divisionType,
    this.phoneCode,
    this.districts,
  });
}

class DistrictEntity {
  final String? name;
  final num? id;
  final String? codeName;
  final String? divisionType;
  final String? shortCodename;
  final List<WardEntity>? wards;

  DistrictEntity({
    this.name,
    this.id,
    this.codeName,
    this.divisionType,
    this.shortCodename,
    this.wards,
  });
}

class WardEntity {
  final String? name;
  final num? id;
  final String? codeName;
  final String? divisionType;
  final String? shortCodename;

  WardEntity(
      {this.name,
      this.id,
      this.codeName,
      this.divisionType,
      this.shortCodename});
}
