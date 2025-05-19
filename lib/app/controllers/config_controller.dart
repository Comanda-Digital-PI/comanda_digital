import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/screens/configs/widgets/image_selector.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ConfigController extends GetxController {
  final TextEditingController nomeProduto = TextEditingController();
  final TextEditingController valorProduto = TextEditingController();

  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString tipoBottomSheet = ''.obs;
  final RxString labelBottomSheet = ''.obs;
  final RxString appBarTitle = ''.obs;

  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> categorias = [
    {'id': 1, 'nome': 'Pratos'},
    {'id': 2, 'nome': 'Bebidas'},
    {'id': 3, 'nome': 'Aperitivos'},
    {'id': 4, 'nome': 'Drinks'},
    {'id': 5, 'nome': 'Sobremesa'},
  ];

  final RxnString categoriaSelecionada = RxnString();

  final RxList<Produto> produtos = <Produto>[].obs;
  final RxList<Produto> produtosFiltered = <Produto>[].obs;
  final RxList<MesaModel> mesas = <MesaModel>[].obs;

  void showBottomSheet(String tipo, String label) {
    tipoBottomSheet.value = tipo;
    labelBottomSheet.value = label;
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

  void adicionarProduto() {
    if (imageFile.value == null) {
      if (kDebugMode) {
        print("Selecione uma imagem antes de adicionar o produto.");
      }
      return;
    }

    produtos.add(Produto(
      nomeProduto: nomeProduto.text,
      valor: double.tryParse(valorProduto.text.toString()) ?? 0.0,
      categoria: categoriaSelecionada.value.toString(),
      image: imageFile.value!.path.toString(),
    ));

    Get.back();
    nomeProduto.clear();
    valorProduto.clear();
    imageFile.value = null;
    categoriaSelecionada.value = null;

    Get.showSnackbar(const GetSnackBar(
      message: 'Produto cadastrado com sucesso!',
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      icon: Icon(Icons.check, color: Colors.white),
    ));
  }

  Future<void> adicionarMesa() async {
    if (nomeProduto.text.isEmpty) {
      if (kDebugMode) {
        print("Digite o número da mesa.");
      }
      return;
    }

    mesas.add(MesaModel(
      numero: int.tryParse(nomeProduto.text) ?? 0,
      status: 'disponivel',
    ));

    Get.back();
    nomeProduto.clear();

    Get.showSnackbar(const GetSnackBar(
      message: 'Mesa cadastrada com sucesso!',
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      icon: Icon(Icons.check, color: Colors.white),
    ));
  }

  TextField buildTextField(label, textController, context,
      {isPassword = false, bool numeric = false}) {
    return TextField(
      controller: textController,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      keyboardType:
          numeric ? const TextInputType.numberWithOptions(decimal: true) : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(fontSize: 20, color: Colors.black),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2),
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
              height: 45,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      labelBottomSheet.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
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
                      if (tipoBottomSheet.value.contains('produto')) ...[
                        productBottomSheet()
                      ] else if (tipoBottomSheet.value.contains('mesa')) ...[
                        mesaBottomSheet()
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

  Column productBottomSheet() {
    return Column(
      children: [
        buildTextField('Nome Produto', nomeProduto, Get.context),
        const SizedBox(
          height: 10,
        ),
        buildTextField('Valor', valorProduto, Get.context, numeric: true),
        const SizedBox(
          height: 20,
        ),
        Form(
          child: DropdownButtonFormField<String>(
            padding: const EdgeInsets.all(8),
            decoration: const InputDecoration(
                labelText: 'Categoria',
                floatingLabelStyle:
                    TextStyle(fontSize: 20, color: Colors.black),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.deepPurple)),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.deepPurple)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurple, width: 2))),
            // O valor selecionado no momento
            value: categoriaSelecionada.value,
            items: categorias.map((categoria) {
              return DropdownMenuItem<String>(
                value: categoria['nome'],
                child: Text(categoria['nome']),
              );
            }).toList(),
            onChanged: (String? newValue) {
              categoriaSelecionada.value = newValue ?? '';
            },
            // Exemplo de validação: obrigatório selecionar uma categoria
            validator: (value) => value == null || value.isEmpty
                ? 'Selecione uma categoria'
                : null,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ImageSelector(controller: Get.find<ConfigController>()),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: SizedBox(
            width: 120,
            child: ElevatedButton.icon(
              onPressed: () {
                adicionarProduto();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              label: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              iconAlignment: IconAlignment.end,
            ),
          ),
        ),
      ],
    );
  }

  Column mesaBottomSheet() {
    return Column(
      children: [
        buildTextField('Número da Mesa', nomeProduto, Get.context,
            numeric: true),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: SizedBox(
            width: 120,
            child: ElevatedButton.icon(
              onPressed: adicionarMesa,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              label:
                  const Text('Salvar', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.save, color: Colors.white),
              iconAlignment: IconAlignment.end,
            ),
          ),
        ),
      ],
    );
  }
}
