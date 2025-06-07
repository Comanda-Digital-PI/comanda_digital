import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/base_products_controller.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/models/pedido_model.dart';

import 'package:get/get.dart';


class PedidoController  extends BaseProductsController
  with ProductsMixin {

  final ConfigController configController = Get.find<ConfigController>();
  final Rxn<String> mesaSelecionada = Rxn<String>();
  final RxList<MesaModel> mesas = <MesaModel>[].obs; 
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> produtosSelecionados = <Map<String, dynamic>>[].obs;
  final Rxn<PedidoModel> pedidoDraft = Rxn<PedidoModel>();
  final RxList<PedidoModel> pedidos = <PedidoModel>[].obs;
  final List<String> statusOptions = ['aberto', 'pronto', 'entregue', 'todos'];
  final RxString selectedStatus = 'aberto'.obs;
  final RxString _dialogStatus = ''.obs;

  List<PedidoModel> get pedidosFiltrados {
    if (selectedStatus.value == 'todos') return pedidos;
    return pedidos.where((p) => p.status == selectedStatus.value).toList();
  }

  @override
  void onInit() async {
    super.onInit();
    _initTudo();
    
  }

  Future<void> _initTudo() async {
    isLoading.value = true;
    // await fetchPedidos();       // seu método
    pedidos.bindStream(_pedidosSnapshotStream());
    isLoading.value = false;         // seu método
  }

   
  Stream<List<PedidoModel>> _pedidosSnapshotStream() {
    return db
      .collection('pedidos')
      .orderBy('numeroPedido')
      .snapshots()
      .map((query) {
        return query.docs.map((doc) {
          final data = doc.data();
          return PedidoModel(
            numeroPedido:   (data['numeroPedido']  as num).toInt(),
            status:         data['status']         as String,
            numeroMesa:     int.parse(data['numeroMesa']),
            valorTotal:     data['valorTotal'],
            produtos:       List<Map<String, dynamic>>.from(data['produtos'] as List),
            dataAbertura:   (data['dataAbertura']  as Timestamp).toDate(),
            dataFechamento: data['dataFechamento'] != null
                ? (data['dataFechamento'] as Timestamp).toDate()
                : null,
          );
        }).toList();
      });
  }

    Future<void> openStatusDialog(PedidoModel pedido) async {
      // inicializa com o status atual
      _dialogStatus.value = pedido.status;

      // mostra diálogo com Obx
      final escolha = await Get.dialog<String>(
        AlertDialog(
          title: const Text('Mudar status do pedido'),
          content: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: statusOptions.where((i) => i != 'todos',).map((s) {
              return RadioListTile<String>(
                title: Text(s.toUpperCase()),
                value: s,
                groupValue: _dialogStatus.value,
                onChanged: (v) => _dialogStatus.value = v!,
              );
            }).toList(),
          )),
          actions: [
            TextButton(
              onPressed: () => Get.back(),      // retorna null
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: _dialogStatus.value),
              child: const Text('SALVAR'),
            ),
          ],
        ),
      );

      // se escolheu e mudou, atualiza
      if (escolha != null && escolha != pedido.status) {
        await updatePedidoStatus(pedido, escolha);
      }
    }


  Future<void> updatePedidoStatus(PedidoModel pedido, String novoStatus) async {
    try {
      final docId = pedido.numeroPedido.toString();
      final dados = {
        'status': novoStatus,
        'dataFechamento': novoStatus == 'entregue' ? Timestamp.now() : null,
      };
      await db.collection('pedidos').doc(docId).update(dados);

      final idx = pedidos.indexWhere((p) => p.numeroPedido == pedido.numeroPedido);
      if (idx >= 0) {
        pedidos[idx] = pedido.copyWith(
          status: novoStatus,
          dataFechamento: novoStatus == 'entregue' ? DateTime.now() : null,
        );
        pedidos.refresh();
      }
    } on FirebaseException catch (e) {
      showError('Erro ao atualizar: ${e.message}');
    }
  }

  Color getStatusColors(status, {bool text = false}) {
    switch (status) {
      case 'aberto':
        return text ? Colors.amber.shade800 : Colors.amber.shade200;
      case 'pronto':
        return text ? Colors.blue.shade800 : Colors.blue.shade200;
      case 'entregue':
        return text ? Colors.green.shade800 : Colors.green.shade200;
      default:
        return text ? Colors.amber.shade800 : Colors.amber.shade200;
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