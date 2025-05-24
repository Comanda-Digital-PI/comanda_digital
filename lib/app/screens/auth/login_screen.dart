import 'package:flutter_faculdade/app/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple.shade800,
                    Colors.deepPurple.shade700,
                    Colors.deepPurple.shade600,
                    // Colors.white,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/komanda.png',
                          height: 120,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildTextField('Email', controller.username, context),
                            const SizedBox(height: 15,),
                            buildTextField('Senha', controller.password, isPassword: true, context, canView: true),
                            const SizedBox(height: 15,),
                            if(controller.isRegistating.isTrue) ... [
                              buildTextField('Confirmar Senha', controller.passwordConfirmation, context, isPassword: true),
                              const SizedBox(height: 15,),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child:     
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FloatingActionButton(
                                        onPressed:() {

                                          if(controller.isRegistating.isTrue){
                                            controller.register();
                                            return;
                                          }
                                          controller.login();
                                        },
                                        backgroundColor: Colors.deepPurpleAccent,
                                        elevation: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.isRegistating.value ? 'Cadastrar e Entrar' : 'Entrar',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                              ),
                                            ),
                                            const SizedBox(width: 15,),
                                            const Icon(
                                              Icons.login,
                                              size: 25,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                            if(controller.isRegistating.isFalse)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Não tem acesso ?',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.isRegistating.value = true;
                                      }, 
                                      child: const Text(
                                        'Registre-se',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.blue
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              )
                            else 
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    controller.isRegistating.value = false;
                                    controller.limparCampos();
                                  }, 
                                  child: const Text(
                                    'Voltar',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue
                                    ),
                                  )
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },);
     
  }

  TextField buildTextField(label, textController, BuildContext context,
      {isPassword = false, canView = false}) {

    final bool auxPassword = isPassword == true ? controller.isPassword.value : false;     
    return TextField(
      controller: textController,
      obscureText: canView ? auxPassword : isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        floatingLabelStyle: const TextStyle(fontSize: 20, color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepPurpleAccent, width: 2),
        ),
        suffixIcon: canView ? IconButton(
          onPressed: () {
            controller.isPassword.value = !controller.isPassword.value;
            
          }, 
          icon: const Icon(
            Icons.remove_red_eye,
            color: Colors.white,
          )
        ) :  null,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
