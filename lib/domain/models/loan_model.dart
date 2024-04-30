import 'package:json_annotation/json_annotation.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';
import 'package:simulador_app/domain/models/simulation_model.dart';

part "loan_model.g.dart";

@JsonSerializable()
class LoanModel {
  late double amount;
  late String currentInstitution;
  late String currentAgreements;
  late List<String>? institutions;
  late List<String>? agreements;
  late List<SimulationModel>? simulations;
  late InstallmentsEnum installments;

  LoanModel({
    this.amount = 0.0,
    this.currentInstitution = "",
    this.currentAgreements = "",
    this.institutions,
    this.agreements,
    this.simulations,
    this.installments = InstallmentsEnum.empty,
  }) {
    institutions = institutions ?? [];
    agreements = agreements ?? [];
    simulations = simulations ?? [];
  }

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanModelToJson(this);
}
