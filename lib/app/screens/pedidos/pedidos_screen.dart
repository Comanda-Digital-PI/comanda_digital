import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/pedido_controller.dart';
import 'package:get/get.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PedidoController controller = Get.put(PedidoController());


    return Obx(() {
      // Enquanto estiver carregando ou ainda não buscou pedidos, mostra indicador
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Se não houver nenhum pedido, exibe mensagem
      if (controller.pedidos.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.receipt_long, size: 60, color: Colors.grey.shade500),
              const SizedBox(height: 12),
              Text(
                'Nenhum pedido registrado',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }

      // Caso existam pedidos, exibe o grid de cards
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 4,
          ),
          itemCount: controller.pedidos.length,
          itemBuilder: (context, index) {
            final pedido = controller.pedidos[index];

            final numeroPedido = pedido.numeroPedido.toString();
            final numeroMesa = pedido.numeroMesa.toString();
            final status = pedido.status;
            final valorTotal = pedido.valorTotal.toStringAsFixed(2);
            final produtosList = pedido.produtos;

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // #Pedido e Mesa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#$numeroPedido',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mesa $numeroMesa',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: status == 'aberto'
                            ? Colors.orange.shade100
                            : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: status == 'aberto'
                              ? Colors.orange.shade800
                              : Colors.green.shade800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Lista de produtos
                    const Text(
                      'Produtos:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: ListView.separated(
                        itemCount: produtosList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 2),
                        itemBuilder: (ctx, i) {
                          final item = produtosList[i];
                          final nome = item['nomeProduto']?.toString() ?? '';
                          final qtd = (item['quantidade'] ?? 0).toString();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  nome,
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'x$qtd',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Valor total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'R\$ $valorTotal',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
