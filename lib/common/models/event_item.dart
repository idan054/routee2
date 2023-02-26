// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    String? title,
    EventCategory? eventCategory,
    @DateTimeStampConv() DateTime? eventAt,
    @DateTimeStampConv() DateTime? createdAt,
    String? latitude,
    String? longitude,
    String? address,
    String? phone,
    int? maxAge,
    int? minAge,

  }) = _EventItem;

  factory EventItem.fromJson(Map<String, dynamic> json) =>
      _$EventItemFromJson(json);
}


