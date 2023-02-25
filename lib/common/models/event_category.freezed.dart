// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventCategory _$EventCategoryFromJson(Map<String, dynamic> json) {
  return _EventCategory.fromJson(json);
}

/// @nodoc
mixin _$EventCategory {
  CategoryType? get categoryType => throw _privateConstructorUsedError;
  String? get categoryName => throw _privateConstructorUsedError;
  @ColorIntConv()
  Color? get categoryColor => throw _privateConstructorUsedError;
  String? get coverImagePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCategoryCopyWith<EventCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCategoryCopyWith<$Res> {
  factory $EventCategoryCopyWith(
          EventCategory value, $Res Function(EventCategory) then) =
      _$EventCategoryCopyWithImpl<$Res, EventCategory>;
  @useResult
  $Res call(
      {CategoryType? categoryType,
      String? categoryName,
      @ColorIntConv() Color? categoryColor,
      String? coverImagePath});
}

/// @nodoc
class _$EventCategoryCopyWithImpl<$Res, $Val extends EventCategory>
    implements $EventCategoryCopyWith<$Res> {
  _$EventCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryType = freezed,
    Object? categoryName = freezed,
    Object? categoryColor = freezed,
    Object? coverImagePath = freezed,
  }) {
    return _then(_value.copyWith(
      categoryType: freezed == categoryType
          ? _value.categoryType
          : categoryType // ignore: cast_nullable_to_non_nullable
              as CategoryType?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColor: freezed == categoryColor
          ? _value.categoryColor
          : categoryColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      coverImagePath: freezed == coverImagePath
          ? _value.coverImagePath
          : coverImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventCategoryCopyWith<$Res>
    implements $EventCategoryCopyWith<$Res> {
  factory _$$_EventCategoryCopyWith(
          _$_EventCategory value, $Res Function(_$_EventCategory) then) =
      __$$_EventCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CategoryType? categoryType,
      String? categoryName,
      @ColorIntConv() Color? categoryColor,
      String? coverImagePath});
}

/// @nodoc
class __$$_EventCategoryCopyWithImpl<$Res>
    extends _$EventCategoryCopyWithImpl<$Res, _$_EventCategory>
    implements _$$_EventCategoryCopyWith<$Res> {
  __$$_EventCategoryCopyWithImpl(
      _$_EventCategory _value, $Res Function(_$_EventCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryType = freezed,
    Object? categoryName = freezed,
    Object? categoryColor = freezed,
    Object? coverImagePath = freezed,
  }) {
    return _then(_$_EventCategory(
      categoryType: freezed == categoryType
          ? _value.categoryType
          : categoryType // ignore: cast_nullable_to_non_nullable
              as CategoryType?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColor: freezed == categoryColor
          ? _value.categoryColor
          : categoryColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      coverImagePath: freezed == coverImagePath
          ? _value.coverImagePath
          : coverImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_EventCategory implements _EventCategory {
  const _$_EventCategory(
      {this.categoryType,
      this.categoryName,
      @ColorIntConv() this.categoryColor,
      this.coverImagePath});

  factory _$_EventCategory.fromJson(Map<String, dynamic> json) =>
      _$$_EventCategoryFromJson(json);

  @override
  final CategoryType? categoryType;
  @override
  final String? categoryName;
  @override
  @ColorIntConv()
  final Color? categoryColor;
  @override
  final String? coverImagePath;

  @override
  String toString() {
    return 'EventCategory(categoryType: $categoryType, categoryName: $categoryName, categoryColor: $categoryColor, coverImagePath: $coverImagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventCategory &&
            (identical(other.categoryType, categoryType) ||
                other.categoryType == categoryType) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            (identical(other.coverImagePath, coverImagePath) ||
                other.coverImagePath == coverImagePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, categoryType, categoryName, categoryColor, coverImagePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCategoryCopyWith<_$_EventCategory> get copyWith =>
      __$$_EventCategoryCopyWithImpl<_$_EventCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventCategoryToJson(
      this,
    );
  }
}

abstract class _EventCategory implements EventCategory {
  const factory _EventCategory(
      {final CategoryType? categoryType,
      final String? categoryName,
      @ColorIntConv() final Color? categoryColor,
      final String? coverImagePath}) = _$_EventCategory;

  factory _EventCategory.fromJson(Map<String, dynamic> json) =
      _$_EventCategory.fromJson;

  @override
  CategoryType? get categoryType;
  @override
  String? get categoryName;
  @override
  @ColorIntConv()
  Color? get categoryColor;
  @override
  String? get coverImagePath;
  @override
  @JsonKey(ignore: true)
  _$$_EventCategoryCopyWith<_$_EventCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
