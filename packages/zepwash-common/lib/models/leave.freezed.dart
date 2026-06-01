// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Leave _$LeaveFromJson(Map<String, dynamic> json) {
  return _Leave.fromJson(json);
}

/// @nodoc
mixin _$Leave {
  String get id => throw _privateConstructorUsedError;
  String get staffId => throw _privateConstructorUsedError;
  String get startDate =>
      throw _privateConstructorUsedError; // Format: yyyy-MM-dd
  String get endDate =>
      throw _privateConstructorUsedError; // Format: yyyy-MM-dd
  String get reason => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'pending' | 'approved' | 'rejected'
  String? get adminNote => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Leave to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveCopyWith<Leave> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveCopyWith<$Res> {
  factory $LeaveCopyWith(Leave value, $Res Function(Leave) then) =
      _$LeaveCopyWithImpl<$Res, Leave>;
  @useResult
  $Res call(
      {String id,
      String staffId,
      String startDate,
      String endDate,
      String reason,
      String status,
      String? adminNote,
      @TimestampConverter() DateTime? approvedAt,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$LeaveCopyWithImpl<$Res, $Val extends Leave>
    implements $LeaveCopyWith<$Res> {
  _$LeaveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? staffId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? reason = null,
    Object? status = null,
    Object? adminNote = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      adminNote: freezed == adminNote
          ? _value.adminNote
          : adminNote // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveImplCopyWith<$Res> implements $LeaveCopyWith<$Res> {
  factory _$$LeaveImplCopyWith(
          _$LeaveImpl value, $Res Function(_$LeaveImpl) then) =
      __$$LeaveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String staffId,
      String startDate,
      String endDate,
      String reason,
      String status,
      String? adminNote,
      @TimestampConverter() DateTime? approvedAt,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$LeaveImplCopyWithImpl<$Res>
    extends _$LeaveCopyWithImpl<$Res, _$LeaveImpl>
    implements _$$LeaveImplCopyWith<$Res> {
  __$$LeaveImplCopyWithImpl(
      _$LeaveImpl _value, $Res Function(_$LeaveImpl) _then)
      : super(_value, _then);

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? staffId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? reason = null,
    Object? status = null,
    Object? adminNote = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$LeaveImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      adminNote: freezed == adminNote
          ? _value.adminNote
          : adminNote // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveImpl implements _Leave {
  const _$LeaveImpl(
      {required this.id,
      required this.staffId,
      required this.startDate,
      required this.endDate,
      required this.reason,
      this.status = 'pending',
      this.adminNote,
      @TimestampConverter() this.approvedAt,
      @TimestampConverter() required this.createdAt});

  factory _$LeaveImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveImplFromJson(json);

  @override
  final String id;
  @override
  final String staffId;
  @override
  final String startDate;
// Format: yyyy-MM-dd
  @override
  final String endDate;
// Format: yyyy-MM-dd
  @override
  final String reason;
  @override
  @JsonKey()
  final String status;
// 'pending' | 'approved' | 'rejected'
  @override
  final String? adminNote;
  @override
  @TimestampConverter()
  final DateTime? approvedAt;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Leave(id: $id, staffId: $staffId, startDate: $startDate, endDate: $endDate, reason: $reason, status: $status, adminNote: $adminNote, approvedAt: $approvedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.adminNote, adminNote) ||
                other.adminNote == adminNote) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, staffId, startDate, endDate,
      reason, status, adminNote, approvedAt, createdAt);

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveImplCopyWith<_$LeaveImpl> get copyWith =>
      __$$LeaveImplCopyWithImpl<_$LeaveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveImplToJson(
      this,
    );
  }
}

abstract class _Leave implements Leave {
  const factory _Leave(
      {required final String id,
      required final String staffId,
      required final String startDate,
      required final String endDate,
      required final String reason,
      final String status,
      final String? adminNote,
      @TimestampConverter() final DateTime? approvedAt,
      @TimestampConverter() required final DateTime createdAt}) = _$LeaveImpl;

  factory _Leave.fromJson(Map<String, dynamic> json) = _$LeaveImpl.fromJson;

  @override
  String get id;
  @override
  String get staffId;
  @override
  String get startDate; // Format: yyyy-MM-dd
  @override
  String get endDate; // Format: yyyy-MM-dd
  @override
  String get reason;
  @override
  String get status; // 'pending' | 'approved' | 'rejected'
  @override
  String? get adminNote;
  @override
  @TimestampConverter()
  DateTime? get approvedAt;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveImplCopyWith<_$LeaveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
