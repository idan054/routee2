// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventItem _$$_EventItemFromJson(Map<String, dynamic> json) => _$_EventItem(
      id: json['id'] as String?,
      title: json['title'] as String?,
      createdAt:
          const DateTimeStampConv().fromJson(json['createdAt'] as Timestamp?),
      distanceFromUser: json['distanceFromUser'] as int?,
      truckType: json['truckType'] as String?,
      originLat: json['originLat'] as String?,
      originLong: json['originLong'] as String?,
      originAddress: json['originAddress'] as String?,
      destinationLat: json['destinationLat'] as String?,
      destinationLong: json['destinationLong'] as String?,
      destinationAddress: json['destinationAddress'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': const DateTimeStampConv().toJson(instance.createdAt),
      'distanceFromUser': instance.distanceFromUser,
      'truckType': instance.truckType,
      'originLat': instance.originLat,
      'originLong': instance.originLong,
      'originAddress': instance.originAddress,
      'destinationLat': instance.destinationLat,
      'destinationLong': instance.destinationLong,
      'destinationAddress': instance.destinationAddress,
      'price': instance.price,
    };
