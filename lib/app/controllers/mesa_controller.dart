import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/models/mesa_model.dart';

class MesaController extends GetxController {
  final db = FirebaseFirestore.instance;
  final mesas = <MesaModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    mesas.bindStream(_mesasStream());
  }

 Stream<List<MesaModel>> _mesasStream() {
    return db.collection('mesas').snapshots().map((snap) =>
      snap.docs.map((d) {
        final data = d.data();
        return MesaModel(
          numero: data['numeroMesa'] as int,
          status: data['status']    as String,
        );
      }).toList()
    );
  }

  Future<void> updateMesaStatus(MesaModel mesa, String novoStatus) async {
    final docId = mesa.numero.toString();
    try {
      await db.collection('mesas').doc(docId)
          .update({'status': novoStatus});

      final idx = mesas.indexWhere((m) => m.numero == mesa.numero);
      if (idx != -1) {
        mesas[idx] = mesa.copyWith(status: novoStatus);
      }
    } on FirebaseException catch (e) {

      Get.showSnackbar(GetSnackBar(
        message: e.message,
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> showChangeStatusDialog(MesaModel mesa) {
    
    return Get.dialog(
      AlertDialog(
        titlePadding: const EdgeInsets.only(top: 20,),
        titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black
        ),
        contentPadding: const EdgeInsets.all(20),
        title: Center(child: Text('Alterar Status da Mesa ${mesa.numero}')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusButton(mesa, 'disponivel', 'Livre', Colors.green),
            const SizedBox(height: 8),
            _buildStatusButton(mesa, 'aguardando', 'Conta!', Colors.blue),
            const SizedBox(height: 8),
            _buildStatusButton(mesa, 'ocupada', 'Ocupada', Colors.red),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
        ],
        // se estiver no Flutter >= 3.7, você pode até usar:
        // actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }

  Widget _buildStatusButton(MesaModel mesa, String statusValue, String label, Color color) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () async {
        await updateMesaStatus(mesa, statusValue);
        Get.back(); // fecha o dialog
      },
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );

  }
}
