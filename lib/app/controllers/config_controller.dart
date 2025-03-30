import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/screens/configs/widgets/image_selector.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ConfigController extends GetxController {

  final TextEditingController nomeProduto = TextEditingController();    
  final TextEditingController valorProduto = TextEditingController();    
  final Rx<File?> imageFile = Rx<File?>(null);

  final RxString tipoBottomSheet = ''.obs;
  final ImagePicker _picker = ImagePicker();

  void showBottomSheet(String tipo){
    tipoBottomSheet.value = tipo;
    showProdutoBottomSheet();
  }

    Future<void> pickImage(ImageSource source) async {
      try {
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          imageFile.value = File(pickedFile.path);
        }
      } catch (e) {
        debugPrint('Erro ao selecionar imagem: $e');
      }
    }


  TextField buildTextField(label, textController, context, {isPassword = false}) {
      return TextField(
        controller: textController,
        obscureText: isPassword,
        style: const TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.deepPurple
          ),
          floatingLabelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple
          ),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
            // borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
          ),

        ),
    );
  }


void showProdutoBottomSheet() {
  Get.bottomSheet(
    Container(
      height: 450,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
            height: 55,
            width: double.infinity,
            
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)
              )
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Novo Produto',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
           ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(tipoBottomSheet.value.contains('produto')) ... [
                      buildTextField('Nome Produto', nomeProduto, Get.context),
                      const SizedBox(height: 10,),
                      buildTextField('Valor', valorProduto, Get.context),
                      const SizedBox(height: 20,),
                      ImageSelector(controller:  Get.find<ConfigController>()),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: SizedBox(
                          width: 120,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              nomeProduto.clear();
                              valorProduto.clear();
                              print(imageFile.value);
                              imageFile.value = null;
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple
                            ),
                            label: const Text(
                              'Salvar',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            icon: const Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            iconAlignment: IconAlignment.end,
                          ),
                        ),
                      )

                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}




}
  
