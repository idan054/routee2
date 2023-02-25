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
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'eventCategory': instance.eventCategory?.toJson(),
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'phone': instance.phone,
    };
