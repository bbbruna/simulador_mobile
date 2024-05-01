import 'package:json_annotation/json_annotation.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';
import 'package:simulador_app/domain/models/simulation_model.dart';

part "loan_model.g.dart";

@JsonSerializable()
class LoanModel {
  late double amount;
  late List<String>? institutions;
  late List<String>? agreements;
  late List<String>? institutionsSelected;
  late List<String>? agreementsSelected;
  late List<SimulationModel>? simulations;
  late InstallmentsEnum installments;

  LoanModel({
    this.amount = 0.0,
    this.institutions,
    this.agreements,
    this.simulations,
    this.institutionsSelected,
    this.agreementsSelected,
    this.installments = InstallmentsEnum.empty,
  }) {
    institutions = institutions ?? [];
    agreements = agreements ?? [];
    institutionsSelected = institutionsSelected ?? [];
    agreementsSelected = agreementsSelected ?? [];
    simulations = simulations ?? [];
  }

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanModelToJson(this);
}
