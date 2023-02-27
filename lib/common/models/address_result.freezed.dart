// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddressResult _$AddressResultFromJson(Map<String, dynamic> json) {
  return _AddressResult.fromJson(json);
}

/// @nodoc
mixin _$AddressResult {
  String? get name => throw _privateConstructorUsedError;
  String? get placeId => throw _privateConstructorUsedError;
  String? get lat => throw _privateConstructorUsedError;
  String? get lng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressResultCopyWith<AddressResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressResultCopyWith<$Res> {
  factory $AddressResultCopyWith(
          AddressResult value, $Res Function(AddressResult) then) =
      _$AddressResultCopyWithImpl<$Res, AddressResult>;
  @useResult
  $Res call({String? name, String? placeId, String? lat, String? lng});
}

/// @nodoc
class _$AddressResultCopyWithImpl<$Res, $Val extends AddressResult>
    implements $AddressResultCopyWith<$Res> {
  _$AddressResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? placeId = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressResultCopyWith<$Res>
    implements $AddressResultCopyWith<$Res> {
  factory _$$_AddressResultCopyWith(
          _$_AddressResult value, $Res Function(_$_AddressResult) then) =
      __$$_AddressResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? placeId, String? lat, String? lng});
}

/// @nodoc
class __$$_AddressResultCopyWithImpl<$Res>
    extends _$AddressResultCopyWithImpl<$Res, _$_AddressResult>
    implements _$$_AddressResultCopyWith<$Res> {
  __$$_AddressResultCopyWithImpl(
      _$_AddressResult _value, $Res Function(_$_AddressResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? placeId = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_$_AddressResult(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_AddressResult implements _AddressResult {
  const _$_AddressResult({this.name, this.placeId, this.lat, this.lng});

  factory _$_AddressResult.fromJson(Map<String, dynamic> json) =>
      _$$_AddressResultFromJson(json);

  @override
  final String? name;
  @override
  final String? placeId;
  @override
  final String? lat;
  @override
  final String? lng;

  @override
  String toString() {
    return 'AddressResult(name: $name, placeId: $placeId, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressResult &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, placeId, lat, lng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressResultCopyWith<_$_AddressResult> get copyWith =>
      __$$_AddressResultCopyWithImpl<_$_AddressResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressResultToJson(
      this,
    );
  }
}

abstract class _AddressResult implements AddressResult {
  const factory _AddressResult(
      {final String? name,
      final String? placeId,
      final String? lat,
      final String? lng}) = _$_AddressResult;

  factory _AddressResult.fromJson(Map<String, dynamic> json) =
      _$_AddressResult.fromJson;

  @override
  String? get name;
  @override
  String? get placeId;
  @override
  String? get lat;
  @override
  String? get lng;
  @override
  @JsonKey(ignore: true)
  _$$_AddressResultCopyWith<_$_AddressResult> get copyWith =>
      throw _privateConstructorUsedError;
}
