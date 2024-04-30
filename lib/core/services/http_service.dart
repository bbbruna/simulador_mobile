import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simulador_app/core/constants/app_constants.dart';
import 'package:simulador_app/domain/models/loan_model.dart';

class HttpService {
  static Future<void> sendSimulate(LoanModel loan) async {
    const String url = "$kApiHost/api/simular";

    final Map<String, String> customHeaders = <String, String>{
      "content-type": "application/json",
    };

    final Map<String, dynamic> payload = {
      "valor_emprestimo": loan.amount.toString(),
      "instituicoes": loan.currentInstitution.isNotEmpty
          ? [loan.currentInstitution]
          : loan.institutions,
      "convenios": [loan.currentAgreements],
      "parcela": loan.installments.intToString,
    };

    final String jsonPayload = jsonEncode(payload);

    await http
        .post(Uri.parse(url), body: jsonPayload, headers: customHeaders)
        .then((response) {

    }).onError((error, stackTrace) {
      print("Erro $error");
    });
  }

  static Future<List<String>> getInstitutions(LoanModel loan) async {
    const String url = "$kApiHost/api/instituicao";

    await http.get(Uri.parse(url)).then((response) {
      final dynamic responseJson = json.decode(response.body);

      for (Map<String, dynamic> element in responseJson) {
        loan.institutions!.add(element["chave"]);
      }
    }).onError((err, stackTrace) {
      return null;
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
}
