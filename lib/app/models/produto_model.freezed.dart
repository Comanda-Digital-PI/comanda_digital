// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Produto {
  String get nomeProduto;
  double get valor;
  String get categoria;
  String get image;

  /// Create a copy of Produto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProdutoCopyWith<Produto> get copyWith =>
      _$ProdutoCopyWithImpl<Produto>(this as Produto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Produto &&
            (identical(other.nomeProduto, nomeProduto) ||
                other.nomeProduto == nomeProduto) &&
            (identical(other.valor, valor) || other.valor == valor) &&
            (identical(other.categoria, categoria) ||
                other.categoria == categoria) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nomeProduto, valor, categoria, image);

  @override
  String toString() {
    return 'Produto(nomeProduto: $nomeProduto, valor: $valor, categoria: $categoria, image: $image)';
  }
}

/// @nodoc
abstract mixin class $ProdutoCopyWith<$Res> {
  factory $ProdutoCopyWith(Produto value, $Res Function(Produto) _then) =
      _$ProdutoCopyWithImpl;
  @useResult
  $Res call({String nomeProduto, double valor, String categoria, String image});
}

/// @nodoc
class _$ProdutoCopyWithImpl<$Res> implements $ProdutoCopyWith<$Res> {
  _$ProdutoCopyWithImpl(this._self, this._then);

  final Produto _self;
  final $Res Function(Produto) _then;

  /// Create a copy of Produto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nomeProduto = null,
    Object? valor = null,
    Object? categoria = null,
    Object? image = null,
  }) {
    return _then(_self.copyWith(
      nomeProduto: null == nomeProduto
          ? _self.nomeProduto
          : nomeProduto // ignore: cast_nullable_to_non_nullable
              as String,
      valor: null == valor
          ? _self.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as double,
      categoria: null == categoria
          ? _self.categoria
          : categoria // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Produto implements Produto {
  _Produto(
      {required this.nomeProduto,
      required this.valor,
      required this.categoria,
      required this.image});

  @override
  final String nomeProduto;
  @override
  final double valor;
  @override
  final String categoria;
  @override
  final String image;

  /// Create a copy of Produto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProdutoCopyWith<_Produto> get copyWith =>
      __$ProdutoCopyWithImpl<_Produto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Produto &&
            (identical(other.nomeProduto, nomeProduto) ||
                other.nomeProduto == nomeProduto) &&
            (identical(other.valor, valor) || other.valor == valor) &&
            (identical(other.categoria, categoria) ||
                other.categoria == categoria) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nomeProduto, valor, categoria, image);

  @override
  String toString() {
    return 'Produto(nomeProduto: $nomeProduto, valor: $valor, categoria: $categoria, image: $image)';
  }
}

/// @nodoc
abstract mixin class _$ProdutoCopyWith<$Res> implements $ProdutoCopyWith<$Res> {
  factory _$ProdutoCopyWith(_Produto value, $Res Function(_Produto) _then) =
      __$ProdutoCopyWithImpl;
  @override
  @useResult
  $Res call({String nomeProduto, double valor, String categoria, String image});
}

/// @nodoc
class __$ProdutoCopyWithImpl<$Res> implements _$ProdutoCopyWith<$Res> {
  __$ProdutoCopyWithImpl(this._self, this._then);

  final _Produto _self;
  final $Res Function(_Produto) _then;

  /// Create a copy of Produto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nomeProduto = null,
    Object? valor = null,
    Object? categoria = null,
    Object? image = null,
  }) {
    return _then(_Produto(
      nomeProduto: null == nomeProduto
          ? _self.nomeProduto
          : nomeProduto // ignore: cast_nullable_to_non_nullable
              as String,
      valor: null == valor
          ? _self.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as double,
      categoria: null == categoria
          ? _self.categoria
          : categoria // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
