// ignore_for_file: invalid_annotation_target
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
part 'event_category.freezed.dart';
part 'event_category.g.dart';

enum CategoryType {
  weekend,
  barPub,
  boardGames,
  otherEvent,
  sport,
  lecture,
  party,
  trip,
  show,
}

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class EventCategory with _$EventCategory {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory EventCategory({
    CategoryType? categoryType,
    String? categoryName,
    @ColorIntConv() Color? categoryColor,
    String? coverImagePath,


  }) = _EventCategory;

  factory EventCategory.fromJson(Map<String, dynamic> json) =>
      _$EventCategoryFromJson(json);
}


