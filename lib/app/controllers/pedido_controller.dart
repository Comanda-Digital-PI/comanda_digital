import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/base_products_controller.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/models/pedido_model.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:get_storage/get_storage.dart';

class PedidoController  extends BaseProductsController
  with ProductsMixin {


// para um único produto
// Get.toNamed(
//   AppRoutes.criaPedido,
//   arguments: produto,
// );
// para vários produtos juntos
// Get.toNamed(
//   AppRoutes.criaPedido,
//   arguments: [produtoA, produtoB, produtoC],
// );
// ou já incluindo quantidade customizada
// Get.toNamed(
//   AppRoutes.criaPedido,
//   arguments: [
//     {'produto': produtoA, 'quantidade': 2},
//     {'produto': produtoB, 'quantidade': 1},
//   ],
// );


  final ConfigController configController = Get.find<ConfigController>();
  final Rxn<String> mesaSelecionada = Rxn<String>();
  final RxList<MesaModel> mesas = <MesaModel>[].obs; 
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> produtosSelecionados = <Map<String, dynamic>>[].obs;
  final Rxn<PedidoModel> pedidoDraft = Rxn<PedidoModel>();
  final RxList<PedidoModel> pedidos = <PedidoModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    _initTudo();
  }

  Future<void> _initTudo() async {
    isLoading.value = true;
    await fetchPedidos();       // seu método
    isLoading.value = false;         // seu método
  }

   
  Future<void> fetchPedidos() async {
    try {
      final query = await db.collection('pedidos').get();

      final lista = query.docs
        // Filtra apenas documentos cujo map não está vazio
        .where((doc) => doc.data().isNotEmpty)
        .map((doc) {
          final data = doc.data();
          print(data);
          return PedidoModel(
            numeroPedido: data['numeroPedido'],
            status: data['status'],
            numeroMesa: int.parse(data['numeroMesa']) ,
            valorTotal: data['valorTotal'],
            produtos:  List<Map<String, dynamic>>.from(data['produtos'] as List<dynamic>),
            dataAbertura:   (data['dataAbertura']  as Timestamp).toDate(),
            dataFechamento: data['dataFechamento'] != null
                ? (data['dataFechamento'] as Timestamp).toDate()
                : null,
          );
        })
        .toList();

      pedidos.assignAll(lista);
    } on FirebaseException catch (e) {
      if (kDebugMode) print('Erro ao buscar pedidos: ${e.message}');
      showError('Falha ao carregar pedidos.');
    }
  }



  
  void showError(String message) {

    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    ));
  }

}