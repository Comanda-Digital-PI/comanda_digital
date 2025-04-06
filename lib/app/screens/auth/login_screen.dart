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
        Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade500,
                Colors.purple.shade300,
                
                // Colors.deepPurple,
              ],
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                      children: [
                        Text(
                          'Comanda Digital',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                          
                      buildTextField('Usuário', controller.username, context),
                      const SizedBox(height: 15,),
                      buildTextField('Senha', controller.password, isPassword: true, context),
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
          ),
        )
    );
   }

   TextField buildTextField(label, textController, BuildContext context, {isPassword = false}) {
     return TextField(
      controller: textController,
      obscureText: isPassword,
      style: const TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
        ),

      ),
    );
   }
   
  
}