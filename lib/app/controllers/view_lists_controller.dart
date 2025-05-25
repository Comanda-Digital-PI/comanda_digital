
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:get/get.dart';

class ViewListsController extends GetxController {

  final db = FirebaseFirestore.instance;
  final RxList<dynamic> filteredList = <dynamic>[].obs;
  final RxString appBarTitle = 'Listas'.obs; 
  final RxString listaSelecionada = ''.obs;
  final RxBool isLoading = false.obs;

  final RxList<Produto> produtos = <Produto>[].obs;
  final RxList<MesaModel> mesas   = <MesaModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }



  Future<void> fetchProdutos() async {
      
    try {
      isLoading.value = true;
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

      filteredList.assignAll(lista);

    } on FirebaseException catch (e) {
      _showError('Falha ao carregar produtos', e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Busca todas as mesas da coleção "mesas" e preenche `mesas`.
  Future<void> fetchMesas() async {
    try {
      isLoading.value = true; 
      final query = await db.collection('mesas').get();
      final lista = query.docs.map((doc) {
        final data = doc.data();
        return MesaModel(
          numero: (data['numeroMesa'] as num).toInt(),
          status: data['status'] as String,
        );
      }).toList();

      filteredList.assignAll(lista);
    } on FirebaseException catch (e) {
      _showError('Falha ao carregar produtos', e);
    } finally {
      isLoading.value = false;
    }
  }


    /// Deleta um produto pelo nome (pressupõe nome único)
  Future<void> deleteProduto(Produto p) async {
    final snap = await db
        .collection('produtos')
        .where('nomeProduto', isEqualTo: p.nomeProduto)
        .get();
    for (var doc in snap.docs) {
      await doc.reference.delete();
    }
    produtos.remove(p);
    filteredList.remove(p);
  }

  /// Atualiza um produto (pressupõe nome único como chave)
  Future<void> updateProduto(Produto old, Produto updated) async {
    final snap = await db
        .collection('produtos')
        .where('nomeProduto', isEqualTo: old.nomeProduto)
        .get();
    if (snap.docs.isNotEmpty) {
      await snap.docs.first.reference.update({
        'nomeProduto': updated.nomeProduto,
        'valor':       updated.valor,
        'categoria':   updated.categoria,
        'image':       updated.image,
      });
      // na lista local:
      final idx = produtos.indexOf(old);
      if (idx != -1) produtos[idx] = updated;
    }
  }

  /// Deleta uma mesa pelo número (ID document = número)
  Future<void> deleteMesa(MesaModel m) async {
    final docId = m.numero.toString();
    await db.collection('mesas').doc(docId).delete();
    mesas.remove(m);
    filteredList.remove(m);
  }

  /// Atualiza uma mesa
  Future<void> updateMesa(MesaModel old, MesaModel updated) async {
    final docId = old.numero.toString();
    await db.collection('mesas').doc(docId).update({
      'numeroMesa': updated.numero,
      'status':     updated.status,
    });
    final idx = mesas.indexOf(old);
    if (idx != -1) mesas[idx] = updated;
  }

  void _showError(String msg, FirebaseException e) {
    isLoading.value = false;
    if (kDebugMode) print('$msg: ${e.message}');
    Get.showSnackbar(GetSnackBar(
      message: msg,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ));
  }
  
}

  
