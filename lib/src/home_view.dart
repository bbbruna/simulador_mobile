import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulador_app/core/services/http_service.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';
import 'package:simulador_app/domain/models/loan_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late LoanModel loanAux = LoanModel();

  late bool canStart = false;

  @override
  void initState() {
    setState(() {
      initInstitutions();
      initAgreements();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Simulação APP"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Valor do empréstimo",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Preencha o valor do empréstimo";
                          }
                          loanAux.amount = double.parse(_amountController.text);
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      buildDropdownInstallments(),
                      const SizedBox(height: 20),
                      buildDropdownInstitutions(),
                      const SizedBox(height: 20),
                      buildDropdownAgreements(),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          await HttpService.sendSimulate(loanAux);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          elevation: 3,
                        ),
                        child: const Text(
                          "Simular",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// start region widgets

  Widget buildDropdownInstallments() {
    return DropdownButton<InstallmentsEnum>(
      value: loanAux.installments.value == 0 ? null : loanAux.installments,
      isExpanded: true,
      hint: const Text("Quantidade de parcelas"),
      onChanged: (InstallmentsEnum? value) {
        setState(() {
          loanAux.installments = value!;
        });
      },
      items: InstallmentsEnum.values
          .map<DropdownMenuItem<InstallmentsEnum>>((InstallmentsEnum value) {
        return DropdownMenuItem<InstallmentsEnum>(
          value: value,
          child: Text(value.value.toString()),
        );
      }).toList(),
    );
  }

  Widget buildDropdownInstitutions() {
    return DropdownButton<String>(
      value: loanAux.currentInstitution.isEmpty
          ? null
          : loanAux.currentInstitution,
      hint: const Text("Instituição"),
      isExpanded: true,
      onChanged: (String? value) {
        setState(() {
          loanAux.currentInstitution = value!;
        });
      },
      items:
          loanAux.institutions!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDropdownAgreements() {
    return DropdownButton<String>(
      hint: const Text("Convênio"),
      value:
          loanAux.currentAgreements.isEmpty ? null : loanAux.currentAgreements,
      isExpanded: true,
      onChanged: (String? value) {
        setState(() {
          loanAux.currentAgreements = value!;
        });
      },
      items: loanAux.agreements?.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  /// endregion widgets

  /// init lists

  Future<void> initInstitutions() async {
    loanAux.institutions = await HttpService.getInstitutions(loanAux);
  }

  Future<void> initAgreements() async {
    loanAux.agreements = await HttpService.getAgreements(loanAux);
  }
}
