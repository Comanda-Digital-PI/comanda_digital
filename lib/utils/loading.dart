import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingUtils {


  static void showLoading({String? message}) async {
    Get.dialog(
      barrierColor: const Color.fromARGB(88, 0, 0, 0),
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           const CircularProgressIndicator(
                   color: Color.fromARGB(255, 0, 62, 231),
           ),
           if (message != null) ...[
             const SizedBox(height: 20), // Espaçamento entre o loader e o texto
             Text(
               message,
               style: const TextStyle(
                 color: Colors.black,
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
                 decoration: TextDecoration.none
               ),
               textAlign: TextAlign.center,
             ),
           ],
         ],
       ),
      barrierDismissible: false, // Evita que o usuário feche ao clicar fora
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Fecha o diálogo de loading
    }
  }
}