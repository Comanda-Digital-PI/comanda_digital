import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';

class MesasScreen extends StatelessWidget {
  const MesasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConfigController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de busca
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar nº da mesa/comanda',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Grid de mesas
          Expanded(
            child: GridView.builder(
              itemCount: controller.mesas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final mesa = controller.mesas[index];
                return _CardMesa(
                  numeroMesa: mesa.numero,
                  status: mesa.status,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendaStatus extends StatelessWidget {
  final Color cor;
  final String texto;

  const _LegendaStatus({required this.cor, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 5),
        Text(texto),
      ],
    );
  }
}

class _CardMesa extends StatelessWidget {
  final int numeroMesa;
  final String status;

  const _CardMesa({required this.numeroMesa, required this.status});

  @override
  Widget build(BuildContext context) {
    Color corDeFundo;
    Widget? destaque;

    switch (status) {
      case 'disponivel':
        corDeFundo = Theme.of(context).colorScheme.primary.withOpacity(0.2);
        destaque = Positioned(
          top: 6,
          right: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Livre',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        break;
      case 'aguardando':
        corDeFundo = Theme.of(context).colorScheme.primary;
        destaque = Positioned(
          top: 6,
          right: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Conta!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        break;
      case 'ocupada':
      default:
        corDeFundo = Theme.of(context).colorScheme.primary;
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: corDeFundo,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Mesa $numeroMesa',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (destaque != null) destaque,
      ],
    );
  }
}
