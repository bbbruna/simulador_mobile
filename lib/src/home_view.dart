import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulador_app/core/services/http_service.dart';
import 'package:simulador_app/domain/enums/installments_enum.dart';
import 'package:simulador_app/domain/models/loan_model.dart';
import 'package:simulador_app/domain/models/simulation_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late LoanModel auxLoan = LoanModel();

  @override
  void initState() {
    initInstitutions();
    initAgreements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Simulação APP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefix: Text("R\$ "),
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
                    auxLoan.amount = double.parse(_amountController.text);
                    return null;
                  },
                ),
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

                  auxLoan.simulations =
                      await HttpService.sendSimulation(auxLoan);

                  setState(() {
                    auxLoan.simulations;
                  });
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
              const SizedBox(height: 20),
              buildListView(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    if (auxLoan.simulations!.isEmpty) {
      return const Text(
        "Nenhum resultado",
        style: TextStyle(fontWeight: FontWeight.w400),
      );
    }
    return SizedBox(
      height: 500,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: auxLoan.simulations!.length,
        itemBuilder: (BuildContext context, int index) {
          final SimulationModel simulation = auxLoan.simulations![index];
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "R\$ ${auxLoan.amount} - ${simulation.installments.value} x R\$ ${auxLoan.amount ~/ simulation.installments.value}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${simulation.institutions} (${simulation.agreement}) - ${simulation.tax}%",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// start region widgets

  Widget buildDropdownInstallments() {
    return DropdownButton<InstallmentsEnum>(
      value: auxLoan.installments.value == 0 ? null : auxLoan.installments,
      isExpanded: true,
      hint: const Text("Quantidade de parcelas"),
      onChanged: (InstallmentsEnum? value) {
        setState(() {
          auxLoan.installments = value!;
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
    return DropdownButtonFormField(
      hint: const Text("Instituição"),
      isExpanded: true,
      onChanged: (String? value) {
        setState(() {
          if (auxLoan.institutionsSelected!.contains(value)) {
            auxLoan.institutionsSelected!.remove(value);
          } else {
            auxLoan.institutionsSelected!.add(value!);
          }
        });
      },
      items:
          auxLoan.institutions!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDropdownAgreements() {
    return DropdownButtonFormField(
      hint: const Text("Convênio"),
      isExpanded: true,
      onChanged: (String? value) {
        setState(() {
          if (auxLoan.agreementsSelected!.contains(value)) {
            auxLoan.agreementsSelected!.remove(value);
          } else {
            auxLoan.agreementsSelected!.add(value!);
          }
        });
      },
      items: auxLoan.agreements!.map<DropdownMenuItem<String>>((String value) {
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
    auxLoan.institutions = await HttpService.getInstitutions(auxLoan);
    setState(() => auxLoan.institutions);
  }

  Future<void> initAgreements() async {
    auxLoan.agreements = await HttpService.getAgreements(auxLoan);
    setState(() => auxLoan.agreements);
  }
}
