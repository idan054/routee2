// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventCategory _$$_EventCategoryFromJson(Map<String, dynamic> json) =>
    _$_EventCategory(
      categoryType:
          $enumDecodeNullable(_$CategoryTypeEnumMap, json['categoryType']),
      categoryName: json['categoryName'] as String?,
      categoryColor: _$JsonConverterFromJson<String, Color>(
          json['categoryColor'], const ColorIntConv().fromJson),
      coverImagePath: json['coverImagePath'] as String?,
    );

Map<String, dynamic> _$$_EventCategoryToJson(_$_EventCategory instance) =>
    <String, dynamic>{
      'categoryType': _$CategoryTypeEnumMap[instance.categoryType],
      'categoryName': instance.categoryName,
      'categoryColor': _$JsonConverterToJson<String, Color>(
          instance.categoryColor, const ColorIntConv().toJson),
      'coverImagePath': instance.coverImagePath,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.weekend: 'weekend',
  CategoryType.barPub: 'barPub',
  CategoryType.boardGames: 'boardGames',
  CategoryType.otherEvent: 'otherEvent',
  CategoryType.sport: 'sport',
  CategoryType.lecture: 'lecture',
  CategoryType.party: 'party',
  CategoryType.trip: 'trip',
  CategoryType.show: 'show',
  CategoryType.volunteer: 'volunteer',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
