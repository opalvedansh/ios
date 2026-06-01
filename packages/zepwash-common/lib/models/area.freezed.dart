// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Area _$AreaFromJson(Map<String, dynamic> json) {
  return _Area.fromJson(json);
}

/// @nodoc
mixin _$Area {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint get center => throw _privateConstructorUsedError;
  double get radiusKm => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, VehiclePricing> get pricing => throw _privateConstructorUsedError;
  List<String> get supervisorIds => throw _privateConstructorUsedError;

  /// Serializes this Area to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AreaCopyWith<Area> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaCopyWith<$Res> {
  factory $AreaCopyWith(Area value, $Res Function(Area) then) =
      _$AreaCopyWithImpl<$Res, Area>;
  @useResult
  $Res call(
      {String id,
      String name,
      String city,
      @GeoPointConverter() GeoPoint center,
      double radiusKm,
      bool isActive,
      Map<String, VehiclePricing> pricing,
      List<String> supervisorIds});
}

/// @nodoc
class _$AreaCopyWithImpl<$Res, $Val extends Area>
    implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = null,
    Object? center = null,
    Object? radiusKm = null,
    Object? isActive = null,
    Object? pricing = null,
    Object? supervisorIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      radiusKm: null == radiusKm
          ? _value.radiusKm
          : radiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      pricing: null == pricing
          ? _value.pricing
          : pricing // ignore: cast_nullable_to_non_nullable
              as Map<String, VehiclePricing>,
      supervisorIds: null == supervisorIds
          ? _value.supervisorIds
          : supervisorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaImplCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$$AreaImplCopyWith(
          _$AreaImpl value, $Res Function(_$AreaImpl) then) =
      __$$AreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String city,
      @GeoPointConverter() GeoPoint center,
      double radiusKm,
      bool isActive,
      Map<String, VehiclePricing> pricing,
      List<String> supervisorIds});
}

/// @nodoc
class __$$AreaImplCopyWithImpl<$Res>
    extends _$AreaCopyWithImpl<$Res, _$AreaImpl>
    implements _$$AreaImplCopyWith<$Res> {
  __$$AreaImplCopyWithImpl(_$AreaImpl _value, $Res Function(_$AreaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = null,
    Object? center = null,
    Object? radiusKm = null,
    Object? isActive = null,
    Object? pricing = null,
    Object? supervisorIds = null,
  }) {
    return _then(_$AreaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      radiusKm: null == radiusKm
          ? _value.radiusKm
          : radiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      pricing: null == pricing
          ? _value._pricing
          : pricing // ignore: cast_nullable_to_non_nullable
              as Map<String, VehiclePricing>,
      supervisorIds: null == supervisorIds
          ? _value._supervisorIds
          : supervisorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaImpl implements _Area {
  const _$AreaImpl(
      {required this.id,
      this.name = 'Unknown Area',
      this.city = 'Unknown City',
      @GeoPointConverter() required this.center,
      this.radiusKm = 0.0,
      this.isActive = true,
      final Map<String, VehiclePricing> pricing = const {},
      final List<String> supervisorIds = const []})
      : _pricing = pricing,
        _supervisorIds = supervisorIds;

  factory _$AreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String city;
  @override
  @GeoPointConverter()
  final GeoPoint center;
  @override
  @JsonKey()
  final double radiusKm;
  @override
  @JsonKey()
  final bool isActive;
  final Map<String, VehiclePricing> _pricing;
  @override
  @JsonKey()
  Map<String, VehiclePricing> get pricing {
    if (_pricing is EqualUnmodifiableMapView) return _pricing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pricing);
  }

  final List<String> _supervisorIds;
  @override
  @JsonKey()
  List<String> get supervisorIds {
    if (_supervisorIds is EqualUnmodifiableListView) return _supervisorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supervisorIds);
  }

  @override
  String toString() {
    return 'Area(id: $id, name: $name, city: $city, center: $center, radiusKm: $radiusKm, isActive: $isActive, pricing: $pricing, supervisorIds: $supervisorIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.radiusKm, radiusKm) ||
                other.radiusKm == radiusKm) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._pricing, _pricing) &&
            const DeepCollectionEquality()
                .equals(other._supervisorIds, _supervisorIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      city,
      center,
      radiusKm,
      isActive,
      const DeepCollectionEquality().hash(_pricing),
      const DeepCollectionEquality().hash(_supervisorIds));

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaImplCopyWith<_$AreaImpl> get copyWith =>
      __$$AreaImplCopyWithImpl<_$AreaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaImplToJson(
      this,
    );
  }
}

abstract class _Area implements Area {
  const factory _Area(
      {required final String id,
      final String name,
      final String city,
      @GeoPointConverter() required final GeoPoint center,
      final double radiusKm,
      final bool isActive,
      final Map<String, VehiclePricing> pricing,
      final List<String> supervisorIds}) = _$AreaImpl;

  factory _Area.fromJson(Map<String, dynamic> json) = _$AreaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get city;
  @override
  @GeoPointConverter()
  GeoPoint get center;
  @override
  double get radiusKm;
  @override
  bool get isActive;
  @override
  Map<String, VehiclePricing> get pricing;
  @override
  List<String> get supervisorIds;

  /// Create a copy of Area
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AreaImplCopyWith<_$AreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VehiclePricing _$VehiclePricingFromJson(Map<String, dynamic> json) {
  return _VehiclePricing.fromJson(json);
}

/// @nodoc
mixin _$VehiclePricing {
  int get monthly => throw _privateConstructorUsedError;
  int get dailyRate => throw _privateConstructorUsedError;
  String get planId => throw _privateConstructorUsedError;

  /// Serializes this VehiclePricing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehiclePricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehiclePricingCopyWith<VehiclePricing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehiclePricingCopyWith<$Res> {
  factory $VehiclePricingCopyWith(
          VehiclePricing value, $Res Function(VehiclePricing) then) =
      _$VehiclePricingCopyWithImpl<$Res, VehiclePricing>;
  @useResult
  $Res call({int monthly, int dailyRate, String planId});
}

/// @nodoc
class _$VehiclePricingCopyWithImpl<$Res, $Val extends VehiclePricing>
    implements $VehiclePricingCopyWith<$Res> {
  _$VehiclePricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehiclePricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthly = null,
    Object? dailyRate = null,
    Object? planId = null,
  }) {
    return _then(_value.copyWith(
      monthly: null == monthly
          ? _value.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int,
      dailyRate: null == dailyRate
          ? _value.dailyRate
          : dailyRate // ignore: cast_nullable_to_non_nullable
              as int,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehiclePricingImplCopyWith<$Res>
    implements $VehiclePricingCopyWith<$Res> {
  factory _$$VehiclePricingImplCopyWith(_$VehiclePricingImpl value,
          $Res Function(_$VehiclePricingImpl) then) =
      __$$VehiclePricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int monthly, int dailyRate, String planId});
}

/// @nodoc
class __$$VehiclePricingImplCopyWithImpl<$Res>
    extends _$VehiclePricingCopyWithImpl<$Res, _$VehiclePricingImpl>
    implements _$$VehiclePricingImplCopyWith<$Res> {
  __$$VehiclePricingImplCopyWithImpl(
      _$VehiclePricingImpl _value, $Res Function(_$VehiclePricingImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehiclePricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthly = null,
    Object? dailyRate = null,
    Object? planId = null,
  }) {
    return _then(_$VehiclePricingImpl(
      monthly: null == monthly
          ? _value.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int,
      dailyRate: null == dailyRate
          ? _value.dailyRate
          : dailyRate // ignore: cast_nullable_to_non_nullable
              as int,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehiclePricingImpl implements _VehiclePricing {
  const _$VehiclePricingImpl(
      {this.monthly = 0, this.dailyRate = 0, this.planId = ''});

  factory _$VehiclePricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehiclePricingImplFromJson(json);

  @override
  @JsonKey()
  final int monthly;
  @override
  @JsonKey()
  final int dailyRate;
  @override
  @JsonKey()
  final String planId;

  @override
  String toString() {
    return 'VehiclePricing(monthly: $monthly, dailyRate: $dailyRate, planId: $planId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehiclePricingImpl &&
            (identical(other.monthly, monthly) || other.monthly == monthly) &&
            (identical(other.dailyRate, dailyRate) ||
                other.dailyRate == dailyRate) &&
            (identical(other.planId, planId) || other.planId == planId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, monthly, dailyRate, planId);

  /// Create a copy of VehiclePricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehiclePricingImplCopyWith<_$VehiclePricingImpl> get copyWith =>
      __$$VehiclePricingImplCopyWithImpl<_$VehiclePricingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehiclePricingImplToJson(
      this,
    );
  }
}

abstract class _VehiclePricing implements VehiclePricing {
  const factory _VehiclePricing(
      {final int monthly,
      final int dailyRate,
      final String planId}) = _$VehiclePricingImpl;

  factory _VehiclePricing.fromJson(Map<String, dynamic> json) =
      _$VehiclePricingImpl.fromJson;

  @override
  int get monthly;
  @override
  int get dailyRate;
  @override
  String get planId;

  /// Create a copy of VehiclePricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehiclePricingImplCopyWith<_$VehiclePricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
