
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/view_lists_controller.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:get/get.dart';

class ViewlistsScreen extends StatelessWidget {
  ViewlistsScreen({super.key});
  
  final ViewListsController controller = Get.put(ViewListsController());

  @override
  Widget build(Object context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.appBarTitle.value
          ),
          backgroundColor: Colors.deepPurple,
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if(controller.listaSelecionada.isNotEmpty) {
                controller.appBarTitle.value = 'Listas';
                controller.listaSelecionada.value = '';
                return;
              }
              print('aqui');
              
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(controller.listaSelecionada.isEmpty) ... [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          height: 60,
                          width: 260,
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.appBarTitle.value = 'Lista de produtos';
                              controller.listaSelecionada.value = 'produtos';
                              await controller.fetchProdutos();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)
                              ),
                              backgroundColor: Colors.deepPurpleAccent,
                              elevation: 3
                            ),
                            child: const Text(
                              'Produtos',
                              style: TextStyle(
                                color: Colors.white,
                                height: 0,
                                fontSize: 15
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          height: 60,
                          width: 260,
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.appBarTitle.value = 'Lista de produtos';
                              controller.listaSelecionada.value = 'mesas';
                              await controller.fetchMesas();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)
                              ),
                              backgroundColor: Colors.deepPurpleAccent,
                              elevation: 3
                            ),
                            child: const Text(
                              'Mesas',
                              style: TextStyle(
                                color: Colors.white,
                                height: 0,
                                fontSize: 15
                              ),
                            )
                          ),
                        ),
                      ),
                    )
                  ] else if (controller.isLoading.isTrue) ... [
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ] else if (controller.listaSelecionada.isNotEmpty) ... [

                    if(controller.filteredList.isEmpty) ... [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_list_bulleted_add,
                                color: Colors.grey.shade800,
                                size: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Não há nada aqui.',
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      )
                    ] else ... [
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.filteredList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (ctx, i) {
                            final item = controller.filteredList[i];
                            Widget tile;
                            if (controller.listaSelecionada.value == 'produtos') {
                              final p = item as Produto;
                              tile = ListTile(
                                title: Text(p.nomeProduto),
                                subtitle: Text('R\$ ${p.valor.toStringAsFixed(2)}  •  ${p.categoria}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.orange),
                                      onPressed: () async {
                                        final novoNome = await _showEditDialog(
                                          context: ctx,
                                          titulo: 'Editar nome do produto',
                                          valorInicial: p.nomeProduto,
                                        );
                                        if (novoNome != null && novoNome.trim().isNotEmpty) {
                                          final atualizado = p.copyWith(nomeProduto: novoNome);
                                          await controller.updateProduto(p, atualizado);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => controller.deleteProduto(p),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final m = item as MesaModel;
                              tile = ListTile(
                                title: Text('Mesa ${m.numero}'),
                                subtitle: Text('Status: ${m.status}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.orange),
                                      onPressed: () async {
                                        final novoStatus = await _showEditDialog(
                                          context: ctx,
                                          titulo: 'Editar status da mesa',
                                          valorInicial: m.status,
                                        );
                                        if (novoStatus != null && novoStatus.trim().isNotEmpty) {
                                          final atualizado = m.copyWith(status: novoStatus);
                                          await controller.updateMesa(m, atualizado);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => controller.deleteMesa(m),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // envolve o tile num card com padding
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: tile,
                              ),
                            );
                          },
                        ),
                      )
                    ]
                  ]
                ],
              ) 
            )
          ],
        ),
      );
    });
  }
  Future<String?> _showEditDialog({
    required BuildContext context,
    required String titulo,
    required String valorInicial,
  }) {
    final ctrl = TextEditingController(text: valorInicial);
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: TextField(controller: ctrl),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, ctrl.text),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}