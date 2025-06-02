// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mesa_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MesaModel {
  int get numero;
  String get status;

  /// Create a copy of MesaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MesaModelCopyWith<MesaModel> get copyWith =>
      _$MesaModelCopyWithImpl<MesaModel>(this as MesaModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MesaModel &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, numero, status);

  @override
  String toString() {
    return 'MesaModel(numero: $numero, status: $status)';
  }
}

/// @nodoc
abstract mixin class $MesaModelCopyWith<$Res> {
  factory $MesaModelCopyWith(MesaModel value, $Res Function(MesaModel) _then) =
      _$MesaModelCopyWithImpl;
  @useResult
  $Res call({int numero, String status});
}

/// @nodoc
class _$MesaModelCopyWithImpl<$Res> implements $MesaModelCopyWith<$Res> {
  _$MesaModelCopyWithImpl(this._self, this._then);

  final MesaModel _self;
  final $Res Function(MesaModel) _then;

  /// Create a copy of MesaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numero = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      numero: null == numero
          ? _self.numero
          : numero // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _MesaModel implements MesaModel {
  const _MesaModel({required this.numero, required this.status});

  @override
  final int numero;
  @override
  final String status;

  /// Create a copy of MesaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MesaModelCopyWith<_MesaModel> get copyWith =>
      __$MesaModelCopyWithImpl<_MesaModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MesaModel &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, numero, status);

  @override
  String toString() {
    return 'MesaModel(numero: $numero, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$MesaModelCopyWith<$Res>
    implements $MesaModelCopyWith<$Res> {
  factory _$MesaModelCopyWith(
          _MesaModel value, $Res Function(_MesaModel) _then) =
      __$MesaModelCopyWithImpl;
  @override
  @useResult
  $Res call({int numero, String status});
}

/// @nodoc
class __$MesaModelCopyWithImpl<$Res> implements _$MesaModelCopyWith<$Res> {
  __$MesaModelCopyWithImpl(this._self, this._then);

  final _MesaModel _self;
  final $Res Function(_MesaModel) _then;

  /// Create a copy of MesaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? numero = null,
    Object? status = null,
  }) {
    return _then(_MesaModel(
      numero: null == numero
          ? _self.numero
          : numero // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
