import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'produto_model.freezed.dart';

@freezed
abstract class Produto with _$Produto {
  factory Produto({
    required String nomeProduto,
    required double valor,
    required String categoria,
    required String image,
  }) = _Produto;
}
