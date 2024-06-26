// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanModel _$LoanModelFromJson(Map<String, dynamic> json) => LoanModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      institutions: (json['institutions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      agreements: (json['agreements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      simulations: (json['simulations'] as List<dynamic>?)
          ?.map((e) => SimulationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      institutionsSelected: (json['institutionsSelected'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      agreementsSelected: (json['agreementsSelected'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      installments: $enumDecodeNullable(
              _$InstallmentsEnumEnumMap, json['installments']) ??
          InstallmentsEnum.empty,
    );

Map<String, dynamic> _$LoanModelToJson(LoanModel instance) => <String, dynamic>{
      'amount': instance.amount,
      'institutions': instance.institutions,
      'agreements': instance.agreements,
      'institutionsSelected': instance.institutionsSelected,
      'agreementsSelected': instance.agreementsSelected,
      'simulations': instance.simulations,
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
