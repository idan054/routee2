// ignore_for_file: invalid_annotation_target
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
part 'address_result.freezed.dart';
part 'address_result.g.dart';


// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class AddressResult with _$AddressResult {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory AddressResult({
    String? name,
    String? placeId,
    String? lat,
    String? lng,


  }) = _AddressResult;

  factory AddressResult.fromJson(Map<String, dynamic> json) =>
      _$AddressResultFromJson(json);
}


