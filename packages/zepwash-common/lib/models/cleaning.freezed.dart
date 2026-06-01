// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cleaning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Cleaning _$CleaningFromJson(Map<String, dynamic> json) {
  return _Cleaning.fromJson(json);
}

/// @nodoc
mixin _$Cleaning {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get staffId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // Format: yyyy-MM-dd
  String get status =>
      throw _privateConstructorUsedError; // 'completed' | 'missed' | 'pending'
  String? get photoUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get staffLocation => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Cleaning to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Cleaning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CleaningCopyWith<Cleaning> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CleaningCopyWith<$Res> {
  factory $CleaningCopyWith(Cleaning value, $Res Function(Cleaning) then) =
      _$CleaningCopyWithImpl<$Res, Cleaning>;
  @useResult
  $Res call(
      {String id,
      String customerId,
      String staffId,
      String date,
      String status,
      String? photoUrl,
      @TimestampConverter() DateTime? completedAt,
      @GeoPointConverter() GeoPoint? staffLocation,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$CleaningCopyWithImpl<$Res, $Val extends Cleaning>
    implements $CleaningCopyWith<$Res> {
  _$CleaningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cleaning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? staffId = null,
    Object? date = null,
    Object? status = null,
    Object? photoUrl = freezed,
    Object? completedAt = freezed,
    Object? staffLocation = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      staffLocation: freezed == staffLocation
          ? _value.staffLocation
          : staffLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CleaningImplCopyWith<$Res>
    implements $CleaningCopyWith<$Res> {
  factory _$$CleaningImplCopyWith(
          _$CleaningImpl value, $Res Function(_$CleaningImpl) then) =
      __$$CleaningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      String staffId,
      String date,
      String status,
      String? photoUrl,
      @TimestampConverter() DateTime? completedAt,
      @GeoPointConverter() GeoPoint? staffLocation,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$CleaningImplCopyWithImpl<$Res>
    extends _$CleaningCopyWithImpl<$Res, _$CleaningImpl>
    implements _$$CleaningImplCopyWith<$Res> {
  __$$CleaningImplCopyWithImpl(
      _$CleaningImpl _value, $Res Function(_$CleaningImpl) _then)
      : super(_value, _then);

  /// Create a copy of Cleaning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? staffId = null,
    Object? date = null,
    Object? status = null,
    Object? photoUrl = freezed,
    Object? completedAt = freezed,
    Object? staffLocation = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$CleaningImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      staffLocation: freezed == staffLocation
          ? _value.staffLocation
          : staffLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CleaningImpl implements _Cleaning {
  const _$CleaningImpl(
      {required this.id,
      required this.customerId,
      required this.staffId,
      required this.date,
      this.status = 'pending',
      this.photoUrl,
      @TimestampConverter() this.completedAt,
      @GeoPointConverter() this.staffLocation,
      @TimestampConverter() required this.createdAt});

  factory _$CleaningImpl.fromJson(Map<String, dynamic> json) =>
      _$$CleaningImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  final String staffId;
  @override
  final String date;
// Format: yyyy-MM-dd
  @override
  @JsonKey()
  final String status;
// 'completed' | 'missed' | 'pending'
  @override
  final String? photoUrl;
  @override
  @TimestampConverter()
  final DateTime? completedAt;
  @override
  @GeoPointConverter()
  final GeoPoint? staffLocation;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Cleaning(id: $id, customerId: $customerId, staffId: $staffId, date: $date, status: $status, photoUrl: $photoUrl, completedAt: $completedAt, staffLocation: $staffLocation, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CleaningImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.staffLocation, staffLocation) ||
                other.staffLocation == staffLocation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, customerId, staffId, date,
      status, photoUrl, completedAt, staffLocation, createdAt);

  /// Create a copy of Cleaning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CleaningImplCopyWith<_$CleaningImpl> get copyWith =>
      __$$CleaningImplCopyWithImpl<_$CleaningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CleaningImplToJson(
      this,
    );
  }
}

abstract class _Cleaning implements Cleaning {
  const factory _Cleaning(
          {required final String id,
          required final String customerId,
          required final String staffId,
          required final String date,
          final String status,
          final String? photoUrl,
          @TimestampConverter() final DateTime? completedAt,
          @GeoPointConverter() final GeoPoint? staffLocation,
          @TimestampConverter() required final DateTime createdAt}) =
      _$CleaningImpl;

  factory _Cleaning.fromJson(Map<String, dynamic> json) =
      _$CleaningImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get staffId;
  @override
  String get date; // Format: yyyy-MM-dd
  @override
  String get status; // 'completed' | 'missed' | 'pending'
  @override
  String? get photoUrl;
  @override
  @TimestampConverter()
  DateTime? get completedAt;
  @override
  @GeoPointConverter()
  GeoPoint? get staffLocation;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of Cleaning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CleaningImplCopyWith<_$CleaningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
