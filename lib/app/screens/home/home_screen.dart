import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/pedido_controller.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/caroussel_promocoes.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/categorias_widget.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/pedidos_card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Expanded(child: 
          Categorias()
        ),

        const Expanded(
          child: CarouselPromocoes()
        ),

        Expanded(
          child: PedidosCard()
        )
      ],
    );
  }


}







