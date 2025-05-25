import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/screens/mesas/widgets/card_mesa.dart';
import 'package:get/get.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';

class MesasScreen extends StatelessWidget {
  const MesasScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ConfigController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra de busca
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar nº da mesa/comanda',
                    hintStyle: TextStyle(color: Colors.deepPurple.shade900),
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurple.shade900),
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
                  cursorColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Grid de mesas
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: controller.mesas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final mesa = controller.mesas[index];
                return CardMesa(
                  numeroMesa: mesa.numero,
                  status: mesa.status,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}


