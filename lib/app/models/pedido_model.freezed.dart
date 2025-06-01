// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pedido_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PedidoModel {
  int get numeroPedido;
  String get status;
  int get numeroMesa;
  double get valorTotal;
  List<dynamic> get produtos;
  DateTime get dataAbertura;
  DateTime? get dataFechamento;

  /// Create a copy of PedidoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PedidoModelCopyWith<PedidoModel> get copyWith =>
      _$PedidoModelCopyWithImpl<PedidoModel>(this as PedidoModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PedidoModel &&
            (identical(other.numeroPedido, numeroPedido) ||
                other.numeroPedido == numeroPedido) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.numeroMesa, numeroMesa) ||
                other.numeroMesa == numeroMesa) &&
            (identical(other.valorTotal, valorTotal) ||
                other.valorTotal == valorTotal) &&
            const DeepCollectionEquality().equals(other.produtos, produtos) &&
            (identical(other.dataAbertura, dataAbertura) ||
                other.dataAbertura == dataAbertura) &&
            (identical(other.dataFechamento, dataFechamento) ||
                other.dataFechamento == dataFechamento));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      numeroPedido,
      status,
      numeroMesa,
      valorTotal,
      const DeepCollectionEquality().hash(produtos),
      dataAbertura,
      dataFechamento);

  @override
  String toString() {
    return 'PedidoModel(numeroPedido: $numeroPedido, status: $status, numeroMesa: $numeroMesa, valorTotal: $valorTotal, produtos: $produtos, dataAbertura: $dataAbertura, dataFechamento: $dataFechamento)';
  }
}

/// @nodoc
abstract mixin class $PedidoModelCopyWith<$Res> {
  factory $PedidoModelCopyWith(
          PedidoModel value, $Res Function(PedidoModel) _then) =
      _$PedidoModelCopyWithImpl;
  @useResult
  $Res call(
      {int numeroPedido,
      String status,
      int numeroMesa,
      double valorTotal,
      List<dynamic> produtos,
      DateTime dataAbertura,
      DateTime? dataFechamento});
}

/// @nodoc
class _$PedidoModelCopyWithImpl<$Res> implements $PedidoModelCopyWith<$Res> {
  _$PedidoModelCopyWithImpl(this._self, this._then);

  final PedidoModel _self;
  final $Res Function(PedidoModel) _then;

  /// Create a copy of PedidoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numeroPedido = null,
    Object? status = null,
    Object? numeroMesa = null,
    Object? valorTotal = null,
    Object? produtos = null,
    Object? dataAbertura = null,
    Object? dataFechamento = freezed,
  }) {
    return _then(_self.copyWith(
      numeroPedido: null == numeroPedido
          ? _self.numeroPedido
          : numeroPedido // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      numeroMesa: null == numeroMesa
          ? _self.numeroMesa
          : numeroMesa // ignore: cast_nullable_to_non_nullable
              as int,
      valorTotal: null == valorTotal
          ? _self.valorTotal
          : valorTotal // ignore: cast_nullable_to_non_nullable
              as double,
      produtos: null == produtos
          ? _self.produtos
          : produtos // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      dataAbertura: null == dataAbertura
          ? _self.dataAbertura
          : dataAbertura // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dataFechamento: freezed == dataFechamento
          ? _self.dataFechamento
          : dataFechamento // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _PedidoModel implements PedidoModel {
  const _PedidoModel(
      {required this.numeroPedido,
      required this.status,
      required this.numeroMesa,
      required this.valorTotal,
      required final List<dynamic> produtos,
      required this.dataAbertura,
      required this.dataFechamento})
      : _produtos = produtos;

  @override
  final int numeroPedido;
  @override
  final String status;
  @override
  final int numeroMesa;
  @override
  final double valorTotal;
  final List<dynamic> _produtos;
  @override
  List<dynamic> get produtos {
    if (_produtos is EqualUnmodifiableListView) return _produtos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produtos);
  }

  @override
  final DateTime dataAbertura;
  @override
  final DateTime? dataFechamento;

  /// Create a copy of PedidoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PedidoModelCopyWith<_PedidoModel> get copyWith =>
      __$PedidoModelCopyWithImpl<_PedidoModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PedidoModel &&
            (identical(other.numeroPedido, numeroPedido) ||
                other.numeroPedido == numeroPedido) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.numeroMesa, numeroMesa) ||
                other.numeroMesa == numeroMesa) &&
            (identical(other.valorTotal, valorTotal) ||
                other.valorTotal == valorTotal) &&
            const DeepCollectionEquality().equals(other._produtos, _produtos) &&
            (identical(other.dataAbertura, dataAbertura) ||
                other.dataAbertura == dataAbertura) &&
            (identical(other.dataFechamento, dataFechamento) ||
                other.dataFechamento == dataFechamento));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      numeroPedido,
      status,
      numeroMesa,
      valorTotal,
      const DeepCollectionEquality().hash(_produtos),
      dataAbertura,
      dataFechamento);

  @override
  String toString() {
    return 'PedidoModel(numeroPedido: $numeroPedido, status: $status, numeroMesa: $numeroMesa, valorTotal: $valorTotal, produtos: $produtos, dataAbertura: $dataAbertura, dataFechamento: $dataFechamento)';
  }
}

/// @nodoc
abstract mixin class _$PedidoModelCopyWith<$Res>
    implements $PedidoModelCopyWith<$Res> {
  factory _$PedidoModelCopyWith(
          _PedidoModel value, $Res Function(_PedidoModel) _then) =
      __$PedidoModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int numeroPedido,
      String status,
      int numeroMesa,
      double valorTotal,
      List<dynamic> produtos,
      DateTime dataAbertura,
      DateTime? dataFechamento});
}

/// @nodoc
class __$PedidoModelCopyWithImpl<$Res> implements _$PedidoModelCopyWith<$Res> {
  __$PedidoModelCopyWithImpl(this._self, this._then);

  final _PedidoModel _self;
  final $Res Function(_PedidoModel) _then;

  /// Create a copy of PedidoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? numeroPedido = null,
    Object? status = null,
    Object? numeroMesa = null,
    Object? valorTotal = null,
    Object? produtos = null,
    Object? dataAbertura = null,
    Object? dataFechamento = freezed,
  }) {
    return _then(_PedidoModel(
      numeroPedido: null == numeroPedido
          ? _self.numeroPedido
          : numeroPedido // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      numeroMesa: null == numeroMesa
          ? _self.numeroMesa
          : numeroMesa // ignore: cast_nullable_to_non_nullable
              as int,
      valorTotal: null == valorTotal
          ? _self.valorTotal
          : valorTotal // ignore: cast_nullable_to_non_nullable
              as double,
      produtos: null == produtos
          ? _self._produtos
          : produtos // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      dataAbertura: null == dataAbertura
          ? _self.dataAbertura
          : dataAbertura // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dataFechamento: freezed == dataFechamento
          ? _self.dataFechamento
          : dataFechamento // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
