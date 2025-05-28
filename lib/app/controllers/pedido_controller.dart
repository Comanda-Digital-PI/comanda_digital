import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/models/pedido_model.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:get/get.dart';

class PedidoController  extends GetxController {


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

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    _loadProdutosFromArguments();
    iniciaPedido();
    await _fetchMesas();
    isLoading.value = false;
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
    );
    
    print(pedidoDraft);
  }
  
  
}