import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simulador_app/core/constants/app_constants.dart';
import 'package:simulador_app/domain/models/loan_model.dart';

class HttpService {
  static Future<void> sendSimulate(LoanModel loan) async {
    final Map<String, dynamic> payload = {
      "valor_emprestimo": loan.amount.toString(),
      "instituicoes": loan.currentInstitution,
      "convenios": loan.currentAgreements,
      "parcela": loan.installments.intToString,
    };

    await http
        .post(Uri.parse("$kApiHost/api/simular"), body: jsonEncode(payload),)
        .then((response) {
      print(response.statusCode);
    }).onError((error, stack) {
      return null;
    });
  }

  static Future<List<String>> getInstitutions(LoanModel loan) async {
    await http.get(Uri.parse("$kApiHost/api/instituicao")).then((response) {
      final dynamic responseJson = json.decode(response.body);

      for (Map<String, dynamic> element in responseJson) {
        loan.institutions!.add(element["valor"]);
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
        loan.agreements!.add(element["valor"]);
      }
    }).onError((error, stack) {
      return null;
    });

    return loan.agreements!;
  }
}
