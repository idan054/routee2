// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventItem _$$_EventItemFromJson(Map<String, dynamic> json) => _$_EventItem(
      title: json['title'] as String?,
      eventCategory: json['eventCategory'] == null
          ? null
          : EventCategory.fromJson(
              json['eventCategory'] as Map<String, dynamic>),
      eventAt:
          const DateTimeStampConv().fromJson(json['eventAt'] as Timestamp?),
      createdAt:
          const DateTimeStampConv().fromJson(json['createdAt'] as Timestamp?),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      maxAge: json['maxAge'] as int?,
      minAge: json['minAge'] as int?,
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'eventCategory': instance.eventCategory?.toJson(),
      'eventAt': const DateTimeStampConv().toJson(instance.eventAt),
      'createdAt': const DateTimeStampConv().toJson(instance.createdAt),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'phone': instance.phone,
      'maxAge': instance.maxAge,
      'minAge': instance.minAge,
    };
