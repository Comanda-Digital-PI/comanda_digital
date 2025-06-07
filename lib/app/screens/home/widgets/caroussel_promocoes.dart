import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/models/produto_model.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CarouselPromocoes extends StatelessWidget {
  const CarouselPromocoes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Promoções',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  height: 0,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                decoration:  BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade500, 
                      width: 1
                    )
                  )
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 170,
              enlargeCenterPage: true,
              autoPlay: true,
              enableInfiniteScroll: false,
            ),
            items:  [
              Card(
                elevation: 2,
                color: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    final produtoA = Produto(
                        nomeProduto: 'Chope IPA',
                        valor: 10.0,
                        categoria: 'Bebidas',
                        image: '',
                      );
                      final produtoB = Produto(
                        nomeProduto: 'Chope IPA',
                        valor: 0.0,
                        categoria: 'Bebidas',
                        image: '',
                      );

                      // 2) Monte uma lista contendo esses dois produtos:
                      final List<Produto> listaDeProdutos = [produtoA, produtoB];

                      // 3) Navegue para a rota de criar pedido, passando a lista como argumento:
                      Get.toNamed(
                        AppRoutes.criaPedido,
                        arguments: listaDeProdutos,
                      );
                  },
                  child: AspectRatio(
                    aspectRatio: 4/3, // largura == altura
                    child: Image.asset(
                      'assets/destaques/combo_chope.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                color: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    
                     final produtoA = Produto(
                        nomeProduto: 'Hamburguer',
                        valor: 25.0,
                        categoria: 'Combo',
                        image: '',
                      );
                      final produtoB = Produto(
                        nomeProduto: 'Coca-Cola',
                        valor: 7.9,
                        categoria: 'Bebidas',
                        image: '',
                      );

                      // 2) Monte uma lista contendo esses dois produtos:
                      final List<Produto> listaDeProdutos = [produtoA, produtoB];

                      // 3) Navegue para a rota de criar pedido, passando a lista como argumento:
                      Get.toNamed(
                        AppRoutes.criaPedido,
                        arguments: listaDeProdutos,
                      );
                  },
                  child: AspectRatio(
                    aspectRatio: 4/3, // largura == altura
                    child: Image.asset(
                      'assets/destaques/combo_burger.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                color: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {

                    final produtoA = Produto(
                      nomeProduto: 'Pizza',
                      valor: 30.0,
                      categoria: 'Pratos',
                      image: '',
                    );

                    final produtoB = Produto(
                      nomeProduto: 'Coca-Cola',
                      valor: 12.9,
                      categoria: 'Bebidas',
                      image: '',
                    );

                    // 2) Monte uma lista contendo esses dois produtos:
                    final List<Produto> listaDeProdutos = [produtoA, produtoB];

                    // 3) Navegue para a rota de criar pedido, passando a lista como argumento:
                    Get.toNamed(
                      AppRoutes.criaPedido,
                      arguments: listaDeProdutos,
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 4/3, // largura == altura
                    child: Image.asset(
                      'assets/destaques/combo_pizza.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
    
      ],
    );
  }
}