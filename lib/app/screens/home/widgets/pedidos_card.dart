import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/pedido_controller.dart';
import 'package:get/get.dart';

class PedidosCard extends StatelessWidget {
  PedidosCard({
    super.key,
    
  });

  final pedidoController = Get.put(PedidoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Prontos para entrega',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    height: 0,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade500, 
                        width: 1
                      )
                    )
                  ),
                ),
              )
            ],
          ),
          if (pedidoController.pedidosProntos.isEmpty) ... [
            const Expanded(
              child: Center(
                child: CircularProgressIndicator()
              ),
            )
          ] else ... [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: pedidoController.pedidosProntos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final pedido = pedidoController.pedidosProntos[i];
                    return SizedBox(
                      width: 120,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => pedidoController.openStatusDialog(pedido),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('#${pedido.numeroPedido}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text('Mesa ${pedido.numeroMesa}',
                                    style: const TextStyle(fontSize: 12)),
                                const Spacer(),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('Total:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'R\$ ${pedido.valorTotal.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color:
                                        pedidoController.getStatusColors('pronto'),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'PRONTO',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: pedidoController.getStatusColors(
                                            'pronto',
                                            text: true),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ]
        ],
      );
    });
  }
}