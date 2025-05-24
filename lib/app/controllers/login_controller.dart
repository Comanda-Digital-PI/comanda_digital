

import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text
      );
      print(credential);
      Get.offNamed(AppRoutes.globalScaffold);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

        Get.showSnackbar( const GetSnackBar(
          message: 'Usuário não encontrado', // Mensagem do snackbar
          duration:  Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin:  EdgeInsets.all(10),
          borderRadius: 8,
          icon:  Icon(Icons.error, color: Colors.white),
        ));
      } else if (e.code == 'wrong-password') {

        Get.showSnackbar( const GetSnackBar(
          message: 'A senha está incorreta.', // Mensagem do snackbar
          duration:  Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin:  EdgeInsets.all(10),
          borderRadius: 8,
          icon:  Icon(Icons.error, color: Colors.white),
        ));
      }
    }


    
  }

}
