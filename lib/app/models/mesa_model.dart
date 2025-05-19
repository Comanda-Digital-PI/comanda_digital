import 'package:freezed_annotation/freezed_annotation.dart';

part 'mesa_model.freezed.dart';

@freezed
abstract class MesaModel with _$MesaModel {
  const factory MesaModel({
    required int numero,
    required String status,
  }) = _MesaModel;
}
