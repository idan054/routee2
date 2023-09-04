// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_details.freezed.dart';
part 'bank_details.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@Freezed(toJson: true)
class BankDetailsModel with _$BankDetailsModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory BankDetailsModel({
    String? accountHolder,
    String? bankName,
    String? branchNumber,
    String? accountNumber,
  }) = _BankDetailsModel;

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsModelFromJson(json);
}
