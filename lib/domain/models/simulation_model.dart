import 'package:json_annotation/json_annotation.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';

part "simulation_model.g.dart";

@JsonSerializable()
class SimulationModel {
  late double tax;
  late double installmentValue;
  late String agreement;
  late InstallmentsEnum installments;

  SimulationModel({
    this.tax = 0.0,
    this.installmentValue = 0.0,
    this.agreement = "",
    this.installments = InstallmentsEnum.empty
  });

  factory SimulationModel.fromJson(Map<String, dynamic> json) =>
      _$SimulationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimulationModelToJson(this);
}
