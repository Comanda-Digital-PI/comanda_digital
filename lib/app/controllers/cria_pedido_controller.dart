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

class CriaPedidoController  extends BaseProductsController
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
    _loadProdutosFromArguments();
    await fetchProdutos();     // do ProductsMixin
    await _fetchMesas();
    iniciaPedido();   
    isLoading.value = false;         // seu método
  }

  void _loadProdutosFromArguments() {
    final args = Get.arguments;
    if (args == null) return;

    // um único Produto
    if (args is Produto) {
      produtosSelecionados.add({
        'produto': args,
        'quantidade': 1,
      });
      print(args);
    }
    // lista de Produtos ou já mapas {produto, quantidade}
    else if (args is List) {
      for (var e in args) {
        if (e is Produto) {
          produtosSelecionados.add({
            'produto': e,
            'quantidade': 1,
          });
        } else if (e is Map<String, dynamic> &&
                   e['produto'] is Produto &&
                   e['quantidade'] is int) {
          produtosSelecionados.add(e);
        }
      }
    }
  }

  Future<void> _fetchMesas() async {
    await configController.fetchMesas();
    mesas.assignAll(configController.mesas);
    isLoading.value = false;
  }

  void iniciaPedido() {
    // 1) corrige quantidades inválidas
    for (var item in produtosSelecionados) {
      final q = item['quantidade'];
      if (q is! int || q < 1) item['quantidade'] = 1;
    }
    produtosSelecionados.refresh();

    // 2) calcula valorTotal
    final total = produtosSelecionados.fold<double>(
      0,
      (sum, item) {
        final p = item['produto'] as Produto;
        final q = item['quantidade'] as int;
        return sum + p.valor * q;
      },
    );

    // 3) monta o draft
    pedidoDraft.value = PedidoModel(
      numeroPedido: 0,      // ajuste conforme sua lógica de ID
      status: 'aberto',
      numeroMesa: 0,        // preencherá quando o usuário escolher
      valorTotal: total,
      produtos: produtosSelecionados.toList(),
      dataAbertura: DateTime.now(),  // registra o instante em que o draft foi criado
      dataFechamento: null,  
    );
    
  }

  Future<void> adicionarProdutoAoPedido(Produto p) async {
    // procura se já há esse produto na lista
    final idx = produtosSelecionados.indexWhere((e) => e['produto'] == p);
    if (idx >= 0) {
      // incrementa a quantidade
      final current = produtosSelecionados[idx]['quantidade'] as int;
      produtosSelecionados[idx]['quantidade'] = current + 1;
    } else {
      // adiciona novo item com quantidade 1
      produtosSelecionados.add({
        'produto': p,
        'quantidade': 1,
      });
    }
    // atualiza observáveis e recalcúla o draft
    produtosSelecionados.refresh();
    iniciaPedido();
  }


  void alteraQuantidade(int index, int novaQtd) {
    if (novaQtd < 1) {
      produtosSelecionados.removeAt(index);
    } else {
      produtosSelecionados[index]['quantidade'] = novaQtd;
    }
    produtosSelecionados.refresh();
    iniciaPedido(); 
  }

  /// Atalho específico para diminuir quantidade em 1 lugar
  void diminuirQuantidade(int index) {
    final current = produtosSelecionados[index]['quantidade'] as int;
    alteraQuantidade(index, current - 1);
  }

  /// Atalho específico para aumentar quantidade em 1 lugar
  void aumentarQuantidade(int index) {
    final current = produtosSelecionados[index]['quantidade'] as int;
    alteraQuantidade(index, current + 1);
  }

  Future<void> criarPedido() async {
    isLoading.value = true;
    if(mesaSelecionada.value == null) {
      showError('É necessário informar a mesa para concluir o pedido');
      return;
    }

    final atual = pedidoDraft.value;
    final numeroMesa = mesaSelecionada.value!.split(' ');
    pedidoDraft.value = atual!.copyWith(
      numeroMesa: int.parse(numeroMesa[0]),
    );

    await savePedidos(pedidoDraft.value!);
    isLoading.value = false;
  }

  Future<void> savePedidos(PedidoModel pedido) async {
    try {

      int numpedido = await getNextNumeroPedido();

      if(numpedido == 0) {
        showError('Erro ao buscar o próximo número do pedido');
        return;
      } 

      final dados = {
        'numeroPedido': numpedido,
        'status': pedido.status,
        'numeroMesa': mesaSelecionada.value,
        'valorTotal': pedido.valorTotal,
        'produtos': pedido.produtos.map((item) {
          return {
            'nomeProduto': (item['produto'] as dynamic).nomeProduto,
            'valor': (item['produto'] as dynamic).valor,
            'quantidade': item['quantidade'] as int,
            'categoria': (item['produto'] as dynamic).categoria,
            'image': (item['produto'] as dynamic).image,
          };
        }).toList(),
        'dataAbertura': pedido.dataAbertura,
        'dataFechamento': pedido.dataFechamento 
      };

      await db.collection('pedidos').doc(numpedido.toString()).set(dados);

      Get.showSnackbar(const GetSnackBar(
        message: 'Pedido salvo com sucesso!',
        backgroundColor: Colors.green,
        duration:  Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        margin:  EdgeInsets.all(10),
        borderRadius: 8,
        icon:  Icon(Icons.error, color: Colors.white),
      ));

      Get.offAllNamed(AppRoutes.globalScaffold);
    
    } on FirebaseException catch (e) {
      if (kDebugMode) print("Erro ao salvar produto: ${e.message}");

      Get.showSnackbar(const GetSnackBar(
        message: 'Falha ao salvar pedido.',
        backgroundColor: Colors.red,
      ));
      return;
    }
  }




  Future<int> getNextNumeroPedido() async {
    try {
      final query = await db
        .collection('pedidos')
        .orderBy('numeroPedido', descending: true)
        .limit(1)
        .get();

      if (query.docs.isEmpty) {
        return 1;
      } else {
        final maior = query.docs.first.data()['numeroPedido'] as int;
        return maior + 1;
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) print('Erro ao buscar próximo ID: ${e.message}');
      return 0; // fallback
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