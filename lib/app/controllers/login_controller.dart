

import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();  

  //pode passar qualquer coisa pro login q vai funcionar
  Future<void> login() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      Get.showSnackbar( const GetSnackBar(
        message: 'Verifique suas credenciais', // Mensagem do snackbar
        duration:  Duration(seconds: 5), // Define a duração
        backgroundColor: Colors.yellow, // Cor de fundo
        snackPosition: SnackPosition.TOP, // Posição do snackbar
        margin:  EdgeInsets.all(10),
        borderRadius: 8,
        icon:  Icon(Icons.warning, color: Colors.white),
      ));
      return;
    }

    Get.offNamed(AppRoutes.globalScaffold);
  }

}
