

import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/utils/loading.dart';
import 'package:flutter_faculdade/utils/session.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();  
  final TextEditingController passwordConfirmation = TextEditingController();  

  final RxBool isPassword = true.obs;
  final RxBool isRegistating = false.obs;

  @override
  void onInit() async {
    super.onInit();
    username.text = (await getSession('user')) ?? '';
  }

  //pode passar qualquer coisa pro login q vai funcionar
  Future<void> login() async {
    LoadingUtils.showLoading();
    if (username.text.isEmpty || password.text.isEmpty) {
      LoadingUtils.hideLoading();
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
      
      setSession('user', username.text);
      limparCampos();
      Get.offAllNamed(AppRoutes.globalScaffold);

    } on FirebaseAuthException catch (e) {
      
      LoadingUtils.hideLoading();
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
      } else if (e.code == 'invalid-credential') {
        Get.showSnackbar( const GetSnackBar(
          message: 'Credenciais inválidas.', // Mensagem do snackbar
          duration:  Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin:  EdgeInsets.all(10),
          borderRadius: 8,
          icon:  Icon(Icons.error, color: Colors.white),
        ));

      } else {
        Get.showSnackbar( GetSnackBar(
          message: e.message, // Mensagem do snackbar
          duration: const Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin: const  EdgeInsets.all(10),
          borderRadius: 8,
          icon: const Icon(Icons.error, color: Colors.white),
        ));

      }

    } finally {
      LoadingUtils.hideLoading();
    }
  }

  Future<void> register() async {
    LoadingUtils.showLoading();
    if(password.text != passwordConfirmation.text){
      LoadingUtils.hideLoading();
      Get.showSnackbar( const GetSnackBar(
        message: 'As senhas devem ser iguais.', // Mensagem do snackbar
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

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username.text,
        password: password.text,
      );

      setSession('user', username.text);
      limparCampos();
      isRegistating.value = false;
      Get.offAllNamed(AppRoutes.globalScaffold);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        LoadingUtils.hideLoading();
        Get.showSnackbar( const GetSnackBar(
          message: 'Crie uma senha mais forte.', // Mensagem do snackbar
          duration:  Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin:  EdgeInsets.all(10),
          borderRadius: 8,
          icon:  Icon(Icons.error, color: Colors.white),
        ));
      } else if (e.code == 'email-already-in-use') {
        LoadingUtils.hideLoading();
        Get.showSnackbar( const GetSnackBar(
          message: 'O email escolhido já está sendo usado.', // Mensagem do snackbar
          duration:  Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin:  EdgeInsets.all(10),
          borderRadius: 8,
          icon:  Icon(Icons.error, color: Colors.white),
        ));
      }
    } catch (e) {
      LoadingUtils.hideLoading();
      Get.showSnackbar( const GetSnackBar(
          message: 'Erro ao criar sua conta.', // Mensagem do snackbar
          duration:  Duration(seconds: 5), // Define a duração
          backgroundColor: Colors.red, // Cor de fundo
          snackPosition: SnackPosition.TOP, // Posição do snackbar
          margin:  EdgeInsets.all(10),
          borderRadius: 8,
          icon:  Icon(Icons.error, color: Colors.white),
        ));
    } finally {
      LoadingUtils.hideLoading();
    }
  }

  void limparCampos(){
    username.clear();
    password.clear();
    passwordConfirmation.clear();
  }

}
