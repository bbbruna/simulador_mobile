import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simulador_app/core/constants/app_constants.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';
import 'package:simulador_app/domain/models/loan_model.dart';
import 'package:simulador_app/domain/models/simulation_model.dart';

class HttpService {
  static final List<SimulationModel> _auxSimulations = [];

  static Future<List<SimulationModel>> sendSimulation(LoanModel loan) async {
    const String url = "$kApiHost/api/simular";

    final Map<String, String> customHeaders = <String, String>{
      "content-type": "application/json",
    };

    final Map<String, dynamic> payload = {
      "valor_emprestimo": loan.amount.toString(),
      "instituicoes": _isInstitutionsSelected(loan),
      "convenios": _isAgreementsSelected(loan),
      "parcelas": loan.installments.intToString,
    };

    final String jsonPayload = jsonEncode(payload);

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonPayload, headers: customHeaders);

      if (response.statusCode == 200) {
        final dynamic responseJson = jsonDecode(response.body);
        return _parseToJson(responseJson, loan);
      } else {
        throw Exception('Failed to send simulation: ${response.statusCode}');
      }
    } catch (error) {
      return [];
    }
  }

  static Future<List<String>> getInstitutions(LoanModel loan) async {
    const String url = "$kApiHost/api/instituicao";

    await http.get(Uri.parse(url)).then((response) {
      final dynamic responseJson = json.decode(response.body);

      for (Map<String, dynamic> element in responseJson) {
        loan.institutions!.add(element["chave"]);
      }
    }).onError((error, stackTrace) {
      return;
    });

    return loan.institutions!;
  }

  static Future<List<String>> getAgreements(LoanModel loan) async {
    await http.get(Uri.parse("$kApiHost/api/convenio")).then((response) {
      final dynamic responseJson = json.decode(response.body);

      for (Map<String, dynamic> element in responseJson) {
        loan.agreements!.add(element["chave"]);
      }
    }).onError((error, stack) {
      return null;
    });

    return loan.agreements!;
  }

  static List<SimulationModel> _parseToJson(
      dynamic responseJson, LoanModel loan) {
    _auxSimulations.clear();
    loan.simulations!.clear();

    if (responseJson == null) {
      return [];
    }

    try {
      for (final institution in _isInstitutionsSelected(loan)) {
        if (responseJson.containsKey(institution)) {
          for (final element in responseJson[institution]) {
            SimulationModel simulation = SimulationModel(
              institutions: institution,
              tax: element["taxa"],
              agreement: element["convenio"],
              installmentValue: element["valor_parcela"] * 0.0,
              installments: InstallmentsEnum.fromValue(element["parcelas"]),
            );

            _auxSimulations.add(simulation);
          }
        }
      }
      loan.simulations = _auxSimulations;
    } catch (e) {
      return [];
    }

    return loan.simulations!;
  }

  static List<String> _isInstitutionsSelected(LoanModel loan) {
    if (loan.institutionsSelected!.isNotEmpty) {
      return loan.institutionsSelected!;
    }

    return loan.institutions!;
  }

  static List<String> _isAgreementsSelected(LoanModel loan) {
    if (loan.agreementsSelected!.isNotEmpty) {
      return loan.agreementsSelected!;
    }

    return loan.agreements!;
  }
}
