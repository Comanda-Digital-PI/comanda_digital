import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/controllers/pedido_controller.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/product_widget.dart';
import 'package:get/get.dart';

class CriaPedidoScreen extends StatelessWidget {
  CriaPedidoScreen({Key? key}) : super(key: key);

  final PedidoController controller = Get.put(PedidoController());
  final ConfigController configController = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Pedido'),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: null,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Lista de itens do pedido
              Expanded(
                flex: 5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: controller.produtosSelecionados.isEmpty
                        ? Column(
                          children: [
                            const Expanded(
                              child: const Center(
                                  child: Text(
                                    'Nenhum item selecionado',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                        final Produto? novo = await Get.to(
                                          () => ProductWidget<PedidoController>(
                                            controller: controller,
                                            title: 'Adicionar Item',
                                          ),
                                        );
                                        if (novo != null) {
                                          controller.adicionarProdutoAoPedido(novo);
                                        }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                      )
                                    ),
                                   label: const Text(
                                    'Adicionar Produto',
                                    style: TextStyle(
                                      color: Colors.white,
                                      
                                    ),
                                   )
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                        : Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                    itemCount: controller.produtosSelecionados.length,
                                    separatorBuilder: (_, __) => const Divider(),
                                    itemBuilder: (_, index) {
                                      final item = controller.produtosSelecionados[index];
                                      final produto = item['produto'] as Produto;
                                      final qtd = item['quantidade'] as int;
                                      return ListTile(
                                        // contentPadding: EdgeInsets.zero,
                                        // dense: true,
                                        tileColor: Colors.grey.shade100,
                                        
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(7))
                                          
                                        ),
                                        title: Text(
                                          produto.nomeProduto,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text('R\$ ${produto.valor.toStringAsFixed(2)} x $qtd'),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove_circle_outline),
                                              onPressed: () => controller.diminuirQuantidade(index),
                                            ),
                                            Text(qtd.toString()),
                                            IconButton(
                                              icon: const Icon(Icons.add_circle_outline),
                                              onPressed: () => controller.aumentarQuantidade(index),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                        final Produto? novo = await Get.to(
                                          () => ProductWidget<PedidoController>(
                                            controller: controller,
                                            title: 'Adicionar Item',
                                          ),
                                        );
                                        if (novo != null) {
                                          controller.adicionarProdutoAoPedido(novo);
                                        }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                      )
                                    ),
                                   label: const Text(
                                    'Adicionar Produto',
                                    style: TextStyle(
                                      color: Colors.white,
                                      
                                    ),
                                   )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                  ),
                ),
              ),

              // const SizedBox(height: 16),

              // Dropdown de seleção de mesa
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Mesa',
                          border: InputBorder.none,
                        ),
                        value: controller.mesaSelecionada.value,
                        items: controller.mesas.map((mesa) {
                          return DropdownMenuItem<String>(
                            value: mesa.numero.toString(),
                            child: Text('Mesa ${mesa.numero}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.mesaSelecionada.value = value;
                        },
                      ),
                    ),
                  ),
                ),
              ),


              // Botão de concluir
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.red
                        ),
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.off(() => ProductWidget<ConfigController>(
                            controller: configController,
                            title: 'Pratos',
                          ));
                        },  
                        label: const Text(
                          'Cancelar Pedido',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.green
                        ),
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (controller.produtosSelecionados.isEmpty ||
                              controller.mesaSelecionada.value == null) {
                            Get.snackbar(
                              'Ops',
                              'Selecione ao menos um item e uma mesa antes de concluir.',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          // controller.concluirPedido();
                        },
                        label: const Text(
                          'Concluir Pedido',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
