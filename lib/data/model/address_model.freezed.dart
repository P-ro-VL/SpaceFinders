// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) {
  return _ProvinceModel.fromJson(json);
}

/// @nodoc
mixin _$ProvinceModel {
  String? get name => throw _privateConstructorUsedError;
  num? get code => throw _privateConstructorUsedError;
  String? get codename => throw _privateConstructorUsedError;
  String? get divisionType => throw _privateConstructorUsedError;
  num? get phoneCode => throw _privateConstructorUsedError;
  List<DistrictModel>? get districts => throw _privateConstructorUsedError;

  /// Serializes this ProvinceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProvinceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProvinceModelCopyWith<ProvinceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProvinceModelCopyWith<$Res> {
  factory $ProvinceModelCopyWith(
          ProvinceModel value, $Res Function(ProvinceModel) then) =
      _$ProvinceModelCopyWithImpl<$Res, ProvinceModel>;
  @useResult
  $Res call(
      {String? name,
      num? code,
      String? codename,
      String? divisionType,
      num? phoneCode,
      List<DistrictModel>? districts});
}

/// @nodoc
class _$ProvinceModelCopyWithImpl<$Res, $Val extends ProvinceModel>
    implements $ProvinceModelCopyWith<$Res> {
  _$ProvinceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProvinceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? codename = freezed,
    Object? divisionType = freezed,
    Object? phoneCode = freezed,
    Object? districts = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      codename: freezed == codename
          ? _value.codename
          : codename // ignore: cast_nullable_to_non_nullable
              as String?,
      divisionType: freezed == divisionType
          ? _value.divisionType
          : divisionType // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneCode: freezed == phoneCode
          ? _value.phoneCode
          : phoneCode // ignore: cast_nullable_to_non_nullable
              as num?,
      districts: freezed == districts
          ? _value.districts
          : districts // ignore: cast_nullable_to_non_nullable
              as List<DistrictModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProvinceModelImplCopyWith<$Res>
    implements $ProvinceModelCopyWith<$Res> {
  factory _$$ProvinceModelImplCopyWith(
          _$ProvinceModelImpl value, $Res Function(_$ProvinceModelImpl) then) =
      __$$ProvinceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      num? code,
      String? codename,
      String? divisionType,
      num? phoneCode,
      List<DistrictModel>? districts});
}

/// @nodoc
class __$$ProvinceModelImplCopyWithImpl<$Res>
    extends _$ProvinceModelCopyWithImpl<$Res, _$ProvinceModelImpl>
    implements _$$ProvinceModelImplCopyWith<$Res> {
  __$$ProvinceModelImplCopyWithImpl(
      _$ProvinceModelImpl _value, $Res Function(_$ProvinceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProvinceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? codename = freezed,
    Object? divisionType = freezed,
    Object? phoneCode = freezed,
    Object? districts = freezed,
  }) {
    return _then(_$ProvinceModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      codename: freezed == codename
          ? _value.codename
          : codename // ignore: cast_nullable_to_non_nullable
              as String?,
      divisionType: freezed == divisionType
          ? _value.divisionType
          : divisionType // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneCode: freezed == phoneCode
          ? _value.phoneCode
          : phoneCode // ignore: cast_nullable_to_non_nullable
              as num?,
      districts: freezed == districts
          ? _value._districts
          : districts // ignore: cast_nullable_to_non_nullable
              as List<DistrictModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$ProvinceModelImpl implements _ProvinceModel {
  _$ProvinceModelImpl(
      {this.name,
      this.code,
      this.codename,
      this.divisionType,
      this.phoneCode,
      final List<DistrictModel>? districts})
      : _districts = districts;

  factory _$ProvinceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProvinceModelImplFromJson(json);

  @override
  final String? name;
  @override
  final num? code;
  @override
  final String? codename;
  @override
  final String? divisionType;
  @override
  final num? phoneCode;
  final List<DistrictModel>? _districts;
  @override
  List<DistrictModel>? get districts {
    final value = _districts;
    if (value == null) return null;
    if (_districts is EqualUnmodifiableListView) return _districts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProvinceModel(name: $name, code: $code, codename: $codename, divisionType: $divisionType, phoneCode: $phoneCode, districts: $districts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProvinceModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.codename, codename) ||
                other.codename == codename) &&
            (identical(other.divisionType, divisionType) ||
                other.divisionType == divisionType) &&
            (identical(other.phoneCode, phoneCode) ||
                other.phoneCode == phoneCode) &&
            const DeepCollectionEquality()
                .equals(other._districts, _districts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, codename,
      divisionType, phoneCode, const DeepCollectionEquality().hash(_districts));

  /// Create a copy of ProvinceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProvinceModelImplCopyWith<_$ProvinceModelImpl> get copyWith =>
      __$$ProvinceModelImplCopyWithImpl<_$ProvinceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProvinceModelImplToJson(
      this,
    );
  }
}

abstract class _ProvinceModel implements ProvinceModel {
  factory _ProvinceModel(
      {final String? name,
      final num? code,
      final String? codename,
      final String? divisionType,
      final num? phoneCode,
      final List<DistrictModel>? districts}) = _$ProvinceModelImpl;

  factory _ProvinceModel.fromJson(Map<String, dynamic> json) =
      _$ProvinceModelImpl.fromJson;

  @override
  String? get name;
  @override
  num? get code;
  @override
  String? get codename;
  @override
  String? get divisionType;
  @override
  num? get phoneCode;
  @override
  List<DistrictModel>? get districts;

  /// Create a copy of ProvinceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProvinceModelImplCopyWith<_$ProvinceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) {
  return _DistrictModel.fromJson(json);
}

/// @nodoc
mixin _$DistrictModel {
  String? get name => throw _privateConstructorUsedError;
  num? get code => throw _privateConstructorUsedError;
  String? get codename => throw _privateConstructorUsedError;
  String? get divisionType => throw _privateConstructorUsedError;
  String? get shortCodename => throw _privateConstructorUsedError;
  List<WardModel>? get wards => throw _privateConstructorUsedError;

  /// Serializes this DistrictModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DistrictModelCopyWith<DistrictModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistrictModelCopyWith<$Res> {
  factory $DistrictModelCopyWith(
          DistrictModel value, $Res Function(DistrictModel) then) =
      _$DistrictModelCopyWithImpl<$Res, DistrictModel>;
  @useResult
  $Res call(
      {String? name,
      num? code,
      String? codename,
      String? divisionType,
      String? shortCodename,
      List<WardModel>? wards});
}

/// @nodoc
class _$DistrictModelCopyWithImpl<$Res, $Val extends DistrictModel>
    implements $DistrictModelCopyWith<$Res> {
  _$DistrictModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? codename = freezed,
    Object? divisionType = freezed,
    Object? shortCodename = freezed,
    Object? wards = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      codename: freezed == codename
          ? _value.codename
          : codename // ignore: cast_nullable_to_non_nullable
              as String?,
      divisionType: freezed == divisionType
          ? _value.divisionType
          : divisionType // ignore: cast_nullable_to_non_nullable
              as String?,
      shortCodename: freezed == shortCodename
          ? _value.shortCodename
          : shortCodename // ignore: cast_nullable_to_non_nullable
              as String?,
      wards: freezed == wards
          ? _value.wards
          : wards // ignore: cast_nullable_to_non_nullable
              as List<WardModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DistrictModelImplCopyWith<$Res>
    implements $DistrictModelCopyWith<$Res> {
  factory _$$DistrictModelImplCopyWith(
          _$DistrictModelImpl value, $Res Function(_$DistrictModelImpl) then) =
      __$$DistrictModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      num? code,
      String? codename,
      String? divisionType,
      String? shortCodename,
      List<WardModel>? wards});
}

/// @nodoc
class __$$DistrictModelImplCopyWithImpl<$Res>
    extends _$DistrictModelCopyWithImpl<$Res, _$DistrictModelImpl>
    implements _$$DistrictModelImplCopyWith<$Res> {
  __$$DistrictModelImplCopyWithImpl(
      _$DistrictModelImpl _value, $Res Function(_$DistrictModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? codename = freezed,
    Object? divisionType = freezed,
    Object? shortCodename = freezed,
    Object? wards = freezed,
  }) {
    return _then(_$DistrictModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      codename: freezed == codename
          ? _value.codename
          : codename // ignore: cast_nullable_to_non_nullable
              as String?,
      divisionType: freezed == divisionType
          ? _value.divisionType
          : divisionType // ignore: cast_nullable_to_non_nullable
              as String?,
      shortCodename: freezed == shortCodename
          ? _value.shortCodename
          : shortCodename // ignore: cast_nullable_to_non_nullable
              as String?,
      wards: freezed == wards
          ? _value._wards
          : wards // ignore: cast_nullable_to_non_nullable
              as List<WardModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DistrictModelImpl implements _DistrictModel {
  _$DistrictModelImpl(
      {this.name,
      this.code,
      this.codename,
      this.divisionType,
      this.shortCodename,
      final List<WardModel>? wards})
      : _wards = wards;

  factory _$DistrictModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DistrictModelImplFromJson(json);

  @override
  final String? name;
  @override
  final num? code;
  @override
  final String? codename;
  @override
  final String? divisionType;
  @override
  final String? shortCodename;
  final List<WardModel>? _wards;
  @override
  List<WardModel>? get wards {
    final value = _wards;
    if (value == null) return null;
    if (_wards is EqualUnmodifiableListView) return _wards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DistrictModel(name: $name, code: $code, codename: $codename, divisionType: $divisionType, shortCodename: $shortCodename, wards: $wards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistrictModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.codename, codename) ||
                other.codename == codename) &&
            (identical(other.divisionType, divisionType) ||
                other.divisionType == divisionType) &&
            (identical(other.shortCodename, shortCodename) ||
                other.shortCodename == shortCodename) &&
            const DeepCollectionEquality().equals(other._wards, _wards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, codename,
      divisionType, shortCodename, const DeepCollectionEquality().hash(_wards));

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistrictModelImplCopyWith<_$DistrictModelImpl> get copyWith =>
      __$$DistrictModelImplCopyWithImpl<_$DistrictModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DistrictModelImplToJson(
      this,
    );
  }
}

abstract class _DistrictModel implements DistrictModel {
  factory _DistrictModel(
      {final String? name,
      final num? code,
      final String? codename,
      final String? divisionType,
      final String? shortCodename,
      final List<WardModel>? wards}) = _$DistrictModelImpl;

  factory _DistrictModel.fromJson(Map<String, dynamic> json) =
      _$DistrictModelImpl.fromJson;

  @override
  String? get name;
  @override
  num? get code;
  @override
  String? get codename;
  @override
  String? get divisionType;
  @override
  String? get shortCodename;
  @override
  List<WardModel>? get wards;

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistrictModelImplCopyWith<_$DistrictModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WardModel _$WardModelFromJson(Map<String, dynamic> json) {
  return _WardModel.fromJson(json);
}

/// @nodoc
mixin _$WardModel {
  String? get name => throw _privateConstructorUsedError;
  num? get code => throw _privateConstructorUsedError;
  String? get codename => throw _privateConstructorUsedError;
  String? get divisionType => throw _privateConstructorUsedError;
  String? get shortCodename => throw _privateConstructorUsedError;

  /// Serializes this WardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WardModelCopyWith<WardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WardModelCopyWith<$Res> {
  factory $WardModelCopyWith(WardModel value, $Res Function(WardModel) then) =
      _$WardModelCopyWithImpl<$Res, WardModel>;
  @useResult
  $Res call(
      {String? name,
      num? code,
      String? codename,
      String? divisionType,
      String? shortCodename});
}

/// @nodoc
class _$WardModelCopyWithImpl<$Res, $Val extends WardModel>
    implements $WardModelCopyWith<$Res> {
  _$WardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? codename = freezed,
    Object? divisionType = freezed,
    Object? shortCodename = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      codename: freezed == codename
          ? _value.codename
          : codename // ignore: cast_nullable_to_non_nullable
              as String?,
      divisionType: freezed == divisionType
          ? _value.divisionType
          : divisionType // ignore: cast_nullable_to_non_nullable
              as String?,
      shortCodename: freezed == shortCodename
          ? _value.shortCodename
          : shortCodename // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WardModelImplCopyWith<$Res>
    implements $WardModelCopyWith<$Res> {
  factory _$$WardModelImplCopyWith(
          _$WardModelImpl value, $Res Function(_$WardModelImpl) then) =
      __$$WardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      num? code,
      String? codename,
      String? divisionType,
      String? shortCodename});
}

/// @nodoc
class __$$WardModelImplCopyWithImpl<$Res>
    extends _$WardModelCopyWithImpl<$Res, _$WardModelImpl>
    implements _$$WardModelImplCopyWith<$Res> {
  __$$WardModelImplCopyWithImpl(
      _$WardModelImpl _value, $Res Function(_$WardModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? codename = freezed,
    Object? divisionType = freezed,
    Object? shortCodename = freezed,
  }) {
    return _then(_$WardModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      codename: freezed == codename
          ? _value.codename
          : codename // ignore: cast_nullable_to_non_nullable
              as String?,
      divisionType: freezed == divisionType
          ? _value.divisionType
          : divisionType // ignore: cast_nullable_to_non_nullable
              as String?,
      shortCodename: freezed == shortCodename
          ? _value.shortCodename
          : shortCodename // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$WardModelImpl implements _WardModel {
  _$WardModelImpl(
      {this.name,
      this.code,
      this.codename,
      this.divisionType,
      this.shortCodename});

  factory _$WardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WardModelImplFromJson(json);

  @override
  final String? name;
  @override
  final num? code;
  @override
  final String? codename;
  @override
  final String? divisionType;
  @override
  final String? shortCodename;

  @override
  String toString() {
    return 'WardModel(name: $name, code: $code, codename: $codename, divisionType: $divisionType, shortCodename: $shortCodename)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WardModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.codename, codename) ||
                other.codename == codename) &&
            (identical(other.divisionType, divisionType) ||
                other.divisionType == divisionType) &&
            (identical(other.shortCodename, shortCodename) ||
                other.shortCodename == shortCodename));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, code, codename, divisionType, shortCodename);

  /// Create a copy of WardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WardModelImplCopyWith<_$WardModelImpl> get copyWith =>
      __$$WardModelImplCopyWithImpl<_$WardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WardModelImplToJson(
      this,
    );
  }
}

abstract class _WardModel implements WardModel {
  factory _WardModel(
      {final String? name,
      final num? code,
      final String? codename,
      final String? divisionType,
      final String? shortCodename}) = _$WardModelImpl;

  factory _WardModel.fromJson(Map<String, dynamic> json) =
      _$WardModelImpl.fromJson;

  @override
  String? get name;
  @override
  num? get code;
  @override
  String? get codename;
  @override
  String? get divisionType;
  @override
  String? get shortCodename;

  /// Create a copy of WardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WardModelImplCopyWith<_$WardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
