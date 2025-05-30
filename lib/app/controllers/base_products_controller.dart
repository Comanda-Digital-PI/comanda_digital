import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/produto_model.dart';


abstract class BaseProductsController extends GetxController {

  RxList<Produto> produtos = <Produto>[].obs;
  RxList<Produto> produtosFiltered = <Produto>[].obs;
  RxBool isLoadingProducts = false.obs;

  Future<void> fetchProdutos();
  void searchProdutos(String query);
}


mixin ProductsMixin on BaseProductsController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> fetchProdutos() async {
    isLoadingProducts.value = true;
    try {
      final query = await db.collection('produtos').get();
      final lista = query.docs.map((doc) {
        final data = doc.data();
        return Produto(
          nomeProduto: data['nomeProduto'] as String,
          valor:       (data['valor'] as num).toDouble(),
          categoria:   data['categoria'] as String,
          image:       data['image'] as String,
        );
      }).toList();

      produtos.assignAll(lista);
      // inicializa a lista filtrada igual à completa
      produtosFiltered.assignAll(lista);
    } on FirebaseException catch (e) {
      if (kDebugMode) print('Erro ao buscar produtos: ${e.message}');
      Get.showSnackbar(const GetSnackBar(
        message: 'Falha ao carregar produtos.',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    } finally {
      isLoadingProducts.value = false;
    }
  }

  @override
  void searchProdutos(String query) {
    final qt = query.trim().toLowerCase();
    if (qt.isEmpty) {
      produtosFiltered.assignAll(produtos);
    } else {
      produtosFiltered.assignAll(produtos.where((p) =>
        p.nomeProduto.toLowerCase().contains(qt)
      ).toList());
    }
  }
}
