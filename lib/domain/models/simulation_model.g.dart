// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulationModel _$SimulationModelFromJson(Map<String, dynamic> json) =>
    SimulationModel(
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      installmentValue: (json['installmentValue'] as num?)?.toDouble() ?? 0.0,
      agreement: json['agreement'] as String,
      installments: $enumDecodeNullable(
              _$InstallmentsEnumEnumMap, json['installments']) ??
          InstallmentsEnum.empty,
    );

Map<String, dynamic> _$SimulationModelToJson(SimulationModel instance) =>
    <String, dynamic>{
      'tax': instance.tax,
      'installmentValue': instance.installmentValue,
      'agreement': instance.agreement,
      'installments': _$InstallmentsEnumEnumMap[instance.installments]!,
    };

const _$InstallmentsEnumEnumMap = {
  InstallmentsEnum.empty: 'empty',
  InstallmentsEnum.thirtySix: 'thirtySix',
  InstallmentsEnum.fortyEight: 'fortyEight',
  InstallmentsEnum.sixty: 'sixty',
  InstallmentsEnum.seventyTwo: 'seventyTwo',
  InstallmentsEnum.eightyFour: 'eightyFour',
};
