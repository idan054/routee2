// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventItem _$$_EventItemFromJson(Map<String, dynamic> json) => _$_EventItem(
      imagePngName: json['imagePngName'] as String?,
      title: json['title'] as String?,
      timestamp:
          const DateTimeStampConv().fromJson(json['timestamp'] as Timestamp?),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'imagePngName': instance.imagePngName,
      'title': instance.title,
      'timestamp': const DateTimeStampConv().toJson(instance.timestamp),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'phone': instance.phone,
    };
