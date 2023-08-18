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
      distanceFromUser: json['distanceFromUser'] as int?,
      truckType: json['truckType'] as String?,
      originLat: json['originLat'] as String?,
      originLong: json['originLong'] as String?,
      originAddress: json['originAddress'] as String?,
      destinationLat: json['destinationLat'] as String?,
      destinationLong: json['destinationLong'] as String?,
      destinationAddress: json['destinationAddress'] as String?,
      feeValue: json['feeValue'] as int?,
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eventCategory': instance.eventCategory?.toJson(),
      'createdAt': const DateTimeStampConv().toJson(instance.createdAt),
      'phone': instance.phone,
      'distanceFromUser': instance.distanceFromUser,
      'truckType': instance.truckType,
      'originLat': instance.originLat,
      'originLong': instance.originLong,
      'originAddress': instance.originAddress,
      'destinationLat': instance.destinationLat,
      'destinationLong': instance.destinationLong,
      'destinationAddress': instance.destinationAddress,
      'feeValue': instance.feeValue,
    };
