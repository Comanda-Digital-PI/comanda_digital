import 'package:flutter/material.dart';

class CardMesa extends StatelessWidget {
  final int numeroMesa;
  final String status;
  final VoidCallback onTap;

  const CardMesa({
    super.key, 
    required this.numeroMesa, 
    required this.status,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    Color corDeFundo;
    Widget? destaque;

    switch (status) {
      case 'disponivel':
        corDeFundo = Theme.of(context).colorScheme.primary;
        destaque = Positioned(
          top: 6,
          right: 6,
          child: Container(
            width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Livre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
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
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Conta!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        break;
      case 'ocupada':
        corDeFundo = Theme.of(context).colorScheme.primary;
        destaque = Positioned(
          top: 6,
          right: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Ocupada',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        break;
      default:
        corDeFundo = Theme.of(context).colorScheme.primary;
    }

    return Stack(
      children: [
        Ink(
          decoration: BoxDecoration(
            color: corDeFundo,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: onTap,
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
        ),
        if (destaque != null) destaque,
      ],
    );
  }
}

