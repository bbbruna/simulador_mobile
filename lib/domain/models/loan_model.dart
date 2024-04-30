import 'package:json_annotation/json_annotation.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';

part "loan_model.g.dart";

@JsonSerializable()
class LoanModel {
  late double amount;
  late String currentInstitution;
  late String currentAgreements;
  late List<String>? institutions;
  late List<String>? agreements;
  late InstallmentsEnum installments;

  LoanModel({
    this.amount = 0.0,
    this.currentInstitution = "",
    this.currentAgreements = "",
    this.institutions,
    this.agreements,
    this.installments = InstallmentsEnum.empty,
  }) {
    institutions = institutions ?? [];
    agreements = agreements ?? [];
  }

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanModelToJson(this);
}
