// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../bank_details/bank_details.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@Freezed(toJson: true)
class UserModel with _$UserModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory UserModel({
    String? fullName,
    String? phone,
    String? truckType,
    String? deliveryCompany,
    BankDetailsModel? bankDetails,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
