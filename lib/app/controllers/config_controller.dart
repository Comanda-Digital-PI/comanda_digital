import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_faculdade/app/controllers/base_products_controller.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/screens/configs/widgets/image_selector.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ConfigController extends BaseProductsController
  with ProductsMixin {

  final TextEditingController nomeProduto = TextEditingController();
  final TextEditingController numMesa = TextEditingController();
  final TextEditingController valorProduto = TextEditingController();

  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString tipoBottomSheet = ''.obs;
  final RxString labelBottomSheet = ''.obs;
  final RxString appBarTitle = ''.obs;
  final RxnString categoriaSelecionada = RxnString();
  final RxList<MesaModel> mesas = <MesaModel>[].obs;
  final RxBool isLoading = false.obs; 

  final ImagePicker _picker = ImagePicker();
  final List<Map<String, dynamic>> categorias = [
    {'id': 1, 'nome': 'Pratos'},
    {'id': 2, 'nome': 'Bebidas'},
    {'id': 3, 'nome': 'Aperitivos'},
    {'id': 4, 'nome': 'Drinks'},
    {'id': 5, 'nome': 'Sobremesa'},
  ];

  @override
  void onInit() async {    
    super.onInit();
    isLoading.value = true;
    await fetchProdutos();
    await fetchMesas();
    isLoading.value = false;
  }


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

  Future<void> adicionarProduto() async {

    if (imageFile.value == null) {
      if (kDebugMode) {
        print("Selecione uma imagem antes de adicionar o produto.");
      }
      return;
    }

    final novoProd = Produto(
      nomeProduto: nomeProduto.text,
      valor: double.tryParse(valorProduto.text.replaceAll(',', '.')) ?? 0.0,
      categoria: categoriaSelecionada.value.toString(),
      image: imageFile.value!.path.toString(),
    );

    if (produtos.any((p) => p.nomeProduto == novoProd.nomeProduto)) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Já existe um produto com esse nome!',
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ));
      return;
    }

      final imageUrl = await saveImagePermanently(imageFile.value!);
      if (imageUrl == null) return; 
    
    await addProductsFirebase(novoProd, imageUrl);
    produtos.add(novoProd.copyWith(image: imageUrl));


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

  Future<void> addProductsFirebase(Produto produto, String imageUrl) async {
    try {
      await db.collection('produtos').add({
        'nomeProduto': produto.nomeProduto,
        'valor':       produto.valor,
        'categoria':   produto.categoria,
        'image':       imageUrl,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) print("Erro ao salvar produto: ${e.message}");

      Get.showSnackbar(const GetSnackBar(
        message: 'Falha ao salvar produto.',
        backgroundColor: Colors.red,
      ));
      return;
    }
  }

  Future<void> addMesaFirebase(MesaModel mesa) async {
    try {
      final docId = mesa.numero.toString();
      await db
        .collection('mesas')
        .doc(docId)            // usa o número da mesa como ID
        .set({
          'numeroMesa': mesa.numero,
          'status':     mesa.status,
        });

    } on FirebaseException catch (e) {
      print('code: ${e.code}');
      if (kDebugMode) print("Erro ao salvar produto: ${e.message}");

      Get.showSnackbar(const GetSnackBar(
        message: 'Falha ao salvar mesa.',
        backgroundColor: Colors.red,
      ));
      return;
    }
  }



  Future<String?> saveImagePermanently(File img) async {
    try {
      // Lê os bytes originais
      final bytes = await img.readAsBytes();

      // Descobre o diretório de documentos (permanente) do app
      final docsDir = await getApplicationDocumentsDirectory();

      // Gera um nome único baseado em timestamp + extensão
      final fileName =
          'produtos_${DateTime.now().millisecondsSinceEpoch}${path.extension(img.path)}';

      // Cria o arquivo no documents
      final newPath = path.join(docsDir.path, fileName);
      final newFile = File(newPath);

      // Escreve os bytes nesse novo arquivo
      await newFile.writeAsBytes(bytes, flush: true);

      // Retorna o caminho completo
      return newPath;
    } catch (e) {
      if (kDebugMode) print('Erro ao salvar imagem permanentemente: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Falha ao salvar imagem localmente.',
        backgroundColor: Colors.red,
      ));
      return null;
    }
  }

  Future<void> adicionarMesa() async {
    if (numMesa.text.isEmpty) {
      if (kDebugMode) {
        print("Digite o número da mesa.");
      }
      return;
    }
    
    MesaModel novaMesa = MesaModel(
      numero: int.tryParse(numMesa.text) ?? 0,
      status: 'disponivel',
    );

    await addMesaFirebase(novaMesa);
    mesas.add(novaMesa);

    Get.back();
    numMesa.clear();

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


  Future<void> showProduct(String categoria) async {
    isLoading.value = true;
    appBarTitle.value = categoria;
    await fetchProdutos();
    produtosFiltered.value = produtos.where((i) => categoria != 'Cardapio' ? i.categoria == categoria : 1==1).toList();
    isLoading.value = false;
  }

  Future<void> fetchMesas() async {
    try {
      final query = await db.collection('mesas').get();
      final lista = query.docs.map((doc) {
        final data = doc.data();
        return MesaModel(
          numero: (data['numeroMesa'] as num).toInt(),
          status: data['status'] as String,
        );
      }).toList();

      mesas.assignAll(lista);
    } on FirebaseException catch (e) {
      if (kDebugMode) print('Erro ao buscar mesas: ${e.message}');
      Get.showSnackbar(const GetSnackBar(
        message: 'Falha ao carregar mesas.',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
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
        buildTextField('Número da Mesa', numMesa, Get.context, numeric: true),
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
