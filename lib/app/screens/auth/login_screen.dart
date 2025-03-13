import 'package:flutter_faculdade/app/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  
  LoginScreen({super.key});
  
  final LoginController controller = Get.put(LoginController());

   @override
   Widget build(BuildContext context) {


    return Scaffold(

      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                    children: [
                      Text(
                        'Comanda Digital',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                        
                    buildTextField('Usuário', controller.username),
                    const SizedBox(height: 15,),
                    buildTextField('Senha', controller.password, isPassword: true),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:     
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: FloatingActionButton(
                                onPressed:() {
                                  controller.login();
                                },
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                elevation: 2,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Entrar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    Icon(
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
                  ],
                ),
              ),
            ),
          ],
        )
    );
   }

   TextField buildTextField(label, textController, {isPassword = false}) {
     return TextField(
      controller: textController,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(
          fontSize: 20
        ),
        enabledBorder: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(Get.context!).colorScheme.primary, width: 2),
          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
        ),
      ),
    );
   }
   
  
}