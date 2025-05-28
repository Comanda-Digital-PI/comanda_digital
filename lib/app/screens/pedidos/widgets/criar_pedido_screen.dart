import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/controllers/pedido_controller.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/caroussel_promocoes.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/categorias_widget.dart';
import 'package:get/get.dart';

class CriaPedidoScreen extends StatelessWidget {

  CriaPedidoScreen({super.key});

  final PedidoController controller = Get.put(PedidoController());
  final ConfigController configController = Get.find<ConfigController>();
  
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedidos'
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: Obx(() {
        return Row(
          children: [
            if(controller.isLoading.isTrue) ... [
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                )
              )
            ] else if (controller.mesas.isNotEmpty) ... [

                Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ← aqui: lista de produtos selecionados
                    
                      Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Container(
                        // ajusta a altura conforme a sua tela
                        height: MediaQuery.of(Get.context!).size.height * 0.5,
                        padding: const EdgeInsets.all(8),
                        child: ListView.separated(
                          itemCount: controller.produtosSelecionados.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 1),
                          itemBuilder: (_, i) {
                            final item = controller.produtosSelecionados[i];
                            final produto = item['produto'] as Produto;
                            final qtd = item['quantidade'] as int;
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(produto.nomeProduto),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () { 
                                    // controller.alteraQuantidade(i, qtd - 1)
                                  },
                                ),
                                Text(qtd.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () { 
                                    // controller.alteraQuantidade(i, qtd + 1)
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    // ← dropdown de mesa (sua estrutura original)
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Card(
                    //     elevation: 3,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(10),
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //             child: SizedBox(
                    //               height: 50,
                    //               child: Form(
                    //                 child: DropdownButtonFormField<String>(
                    //                   iconEnabledColor: Colors.black,
                    //                   iconSize: 30,
                    //                   decoration: const InputDecoration(
                    //                     labelText: 'Mesa',
                    //                     labelStyle:
                    //                         TextStyle(color: Colors.black),
                    //                     floatingLabelStyle: TextStyle(
                    //                         fontSize: 20,
                    //                         color: Colors.black),
                    //                     border: OutlineInputBorder(
                    //                       borderSide: BorderSide(
                    //                           width: 2,
                    //                           color: Colors.deepPurple),
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(10)),
                    //                     ),
                    //                     disabledBorder: OutlineInputBorder(
                    //                       borderSide: BorderSide(
                    //                           width: 2,
                    //                           color: Colors.deepPurple),
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(10)),
                    //                     ),
                    //                     enabledBorder: OutlineInputBorder(
                    //                       borderSide: BorderSide(
                    //                           color: Colors.deepPurple,
                    //                           width: 2),
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(10)),
                    //                     ),
                    //                   ),
                    //                   hint: const Text(
                    //                     'Selecione uma mesa',
                    //                     style: TextStyle(
                    //                         height: 0, color: Colors.black),
                    //                   ),
                    //                   value: controller.mesaSelecionada.value,
                    //                   items: controller.mesas.map((mesa) {
                    //                     return DropdownMenuItem<String>(
                    //                       value: 'Mesa ${mesa.numero}',
                    //                       child: Text('Mesa ${mesa.numero}'),
                    //                     );
                    //                   }).toList(),
                    //                   onChanged: (String? newValue) {
                    //                     controller.mesaSelecionada.value =
                    //                         newValue ?? '';
                    //                   },
                    //                   validator: (value) => value == null ||
                    //                           value.isEmpty
                    //                       ? 'Selecione uma mesa'
                    //                       : null,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ]
          ],
        );
      },)
    );
      
  }
}





