import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pedido_model.freezed.dart';

@freezed
abstract class PedidoModel with _$PedidoModel {
  const factory PedidoModel({
    required int numeroPedido,
    required String status,
    required int numeroMesa,
    required double valorTotal,
    required List<dynamic> produtos,
    required DateTime dataAbertura,
    required DateTime? dataFechamento

  }) = _PedidoModel;
}