// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventItem _$EventItemFromJson(Map<String, dynamic> json) {
  return _EventItem.fromJson(json);
}

/// @nodoc
mixin _$EventItem {
// String? imagePngName,
  String? get title => throw _privateConstructorUsedError;
  EventCategory? get eventCategory => throw _privateConstructorUsedError;
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventItemCopyWith<EventItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventItemCopyWith<$Res> {
  factory $EventItemCopyWith(EventItem value, $Res Function(EventItem) then) =
      _$EventItemCopyWithImpl<$Res, EventItem>;
  @useResult
  $Res call(
      {String? title,
      EventCategory? eventCategory,
      @DateTimeStampConv() DateTime? timestamp,
      String? latitude,
      String? longitude,
      String? address,
      String? phone});

  $EventCategoryCopyWith<$Res>? get eventCategory;
}

/// @nodoc
class _$EventItemCopyWithImpl<$Res, $Val extends EventItem>
    implements $EventItemCopyWith<$Res> {
  _$EventItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? eventCategory = freezed,
    Object? timestamp = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      eventCategory: freezed == eventCategory
          ? _value.eventCategory
          : eventCategory // ignore: cast_nullable_to_non_nullable
              as EventCategory?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventCategoryCopyWith<$Res>? get eventCategory {
    if (_value.eventCategory == null) {
      return null;
    }

    return $EventCategoryCopyWith<$Res>(_value.eventCategory!, (value) {
      return _then(_value.copyWith(eventCategory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventItemCopyWith<$Res> implements $EventItemCopyWith<$Res> {
  factory _$$_EventItemCopyWith(
          _$_EventItem value, $Res Function(_$_EventItem) then) =
      __$$_EventItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      EventCategory? eventCategory,
      @DateTimeStampConv() DateTime? timestamp,
      String? latitude,
      String? longitude,
      String? address,
      String? phone});

  @override
  $EventCategoryCopyWith<$Res>? get eventCategory;
}

/// @nodoc
class __$$_EventItemCopyWithImpl<$Res>
    extends _$EventItemCopyWithImpl<$Res, _$_EventItem>
    implements _$$_EventItemCopyWith<$Res> {
  __$$_EventItemCopyWithImpl(
      _$_EventItem _value, $Res Function(_$_EventItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? eventCategory = freezed,
    Object? timestamp = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
    Object? phone = freezed,
  }) {
    return _then(_$_EventItem(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      eventCategory: freezed == eventCategory
          ? _value.eventCategory
          : eventCategory // ignore: cast_nullable_to_non_nullable
              as EventCategory?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_EventItem implements _EventItem {
  const _$_EventItem(
      {this.title,
      this.eventCategory,
      @DateTimeStampConv() this.timestamp,
      this.latitude,
      this.longitude,
      this.address,
      this.phone});

  factory _$_EventItem.fromJson(Map<String, dynamic> json) =>
      _$$_EventItemFromJson(json);

// String? imagePngName,
  @override
  final String? title;
  @override
  final EventCategory? eventCategory;
  @override
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  final String? latitude;
  @override
  final String? longitude;
  @override
  final String? address;
  @override
  final String? phone;

  @override
  String toString() {
    return 'EventItem(title: $title, eventCategory: $eventCategory, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, address: $address, phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.eventCategory, eventCategory) ||
                other.eventCategory == eventCategory) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, eventCategory, timestamp,
      latitude, longitude, address, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventItemCopyWith<_$_EventItem> get copyWith =>
      __$$_EventItemCopyWithImpl<_$_EventItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventItemToJson(
      this,
    );
  }
}

abstract class _EventItem implements EventItem {
  const factory _EventItem(
      {final String? title,
      final EventCategory? eventCategory,
      @DateTimeStampConv() final DateTime? timestamp,
      final String? latitude,
      final String? longitude,
      final String? address,
      final String? phone}) = _$_EventItem;

  factory _EventItem.fromJson(Map<String, dynamic> json) =
      _$_EventItem.fromJson;

  @override // String? imagePngName,
  String? get title;
  @override
  EventCategory? get eventCategory;
  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  @JsonKey(ignore: true)
  _$$_EventItemCopyWith<_$_EventItem> get copyWith =>
      throw _privateConstructorUsedError;
}
