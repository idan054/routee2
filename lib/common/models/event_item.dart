// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import 'event_category.dart';

part 'event_item.freezed.dart';
part 'event_item.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class EventItem with _$EventItem {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory EventItem({
    // String? imagePngName,
    String? id,
    String? title,
    EventCategory? eventCategory,
    @DateTimeStampConv() DateTime? createdAt,
    String? phone, // To contact
    int? distanceFromUser, // Example 50 Meter away...

    String? truckType,
    String? originLat,
    String? originLong,
    String? originAddress,
    String? destinationLat,
    String? destinationLong,
    String? destinationAddress,
    int? feeValue,
  }) = _EventItem;

  factory EventItem.fromJson(Map<String, dynamic> json) => _$EventItemFromJson(json);
}
