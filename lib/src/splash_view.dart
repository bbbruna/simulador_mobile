import 'package:flutter/material.dart';
import 'package:simulador_app/src/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    redirectToMain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.account_balance_sharp,
          color: Colors.deepPurple,
          size: 36.0,
        ),
      ),
    );
  }

  void redirectToMain() {
    Future.delayed(const Duration(seconds: 4)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    });
  }
}
