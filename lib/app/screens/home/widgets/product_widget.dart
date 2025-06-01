// lib/app/screens/product_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/cria_pedido_controller.dart';
import 'package:flutter_faculdade/app/controllers/pedido_controller.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:get/get.dart';
import 'package:flutter_faculdade/app/controllers/base_products_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';

class ProductWidget<C extends BaseProductsController> extends StatelessWidget {
  final C controller;
  final String title;

  const ProductWidget({
    Key? key,
    required this.controller,
    this.title = 'Produtos',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dispara fetch na primeira build
    if (controller.produtos.isEmpty && !controller.isLoadingProducts.value) {
      controller.fetchProdutos();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Obx(() {
        if (controller.isLoadingProducts.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar produto',
                  prefixIcon: const Icon(Icons.search),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(3))
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(3))
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(3))
                  ),
                ),
                onChanged: controller.searchProdutos,
              ),
            ),
            Expanded(
              child: controller.produtosFiltered.isEmpty
                  ? const Center(child: Text('Nenhum produto encontrado'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3/4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: controller.produtosFiltered.length,
                      itemBuilder: (_, i) {
                        final p = controller.produtosFiltered[i];
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                                final Produto escolhido = p;
                                // Se já existe um PedidoController vivo na stack, 
                                // significa que estamos dentro de CriaPedidoScreen:
                                if (Get.isRegistered<CriaPedidoController>()) {
                                  // volta para CriaPedidoScreen passando o produto
                                  Get.back(result: escolhido);
                                } else {
                                  // caso contrário, ninguém está aguardando um pedido: 
                                  // cria um novo pedido na tela CriaPedidoScreen
                                  Get.toNamed(
                                    AppRoutes.criaPedido,
                                    arguments: [escolhido],
                                  );
                                }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Image.file(File(p.image), fit: BoxFit.cover),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(p.nomeProduto, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5),
                                      Text(p.categoria, style: const TextStyle(fontSize: 12)),
                                      const SizedBox(height: 5),
                                      Text("R\$ ${p.valor.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
