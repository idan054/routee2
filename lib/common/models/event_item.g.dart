// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventItem _$$_EventItemFromJson(Map<String, dynamic> json) => _$_EventItem(
      id: json['id'] as String?,
      title: json['title'] as String?,
      eventCategory: json['eventCategory'] == null
          ? null
          : EventCategory.fromJson(
              json['eventCategory'] as Map<String, dynamic>),
      createdAt:
          const DateTimeStampConv().fromJson(json['createdAt'] as Timestamp?),
      phone: json['phone'] as String?,
      ageRange: json['ageRange'] as List<dynamic>?,
      distanceFromUser: json['distanceFromUser'] as int?,
      address: json['address'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      withFee: json['withFee'] as bool?,
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eventCategory': instance.eventCategory?.toJson(),
      'createdAt': const DateTimeStampConv().toJson(instance.createdAt),
      'phone': instance.phone,
      'ageRange': instance.ageRange,
      'distanceFromUser': instance.distanceFromUser,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'withFee': instance.withFee,
    };
