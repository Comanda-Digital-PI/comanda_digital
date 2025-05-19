import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.login); // redireciona para login
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.purple.shade900,
          Colors.purple.shade800,
          Colors.purple.shade600,
          Colors.purple.shade400,
          Colors.white,
        ],
      )),
      child: Center(
        child: Image.asset('assets/KO.gif', width: 950),
      ),
    ));
  }
}
