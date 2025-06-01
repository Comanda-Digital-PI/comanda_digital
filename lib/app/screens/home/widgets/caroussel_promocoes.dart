import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              // height: double.infinity,
              enlargeCenterPage: true,
              autoPlay: true,
              enableInfiniteScroll: false,
            ),
            items:  [
              Card(
                elevation: 3,
                color: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 4/3, // largura == altura
                  child: Image.asset(
                    'assets/destaques/combo_chope.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Card(
                elevation: 3,
                color: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 4/3, // largura == altura
                  child: Image.asset(
                    'assets/destaques/combo_burger.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Card(
                elevation: 3,
                color: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 4/3, // largura == altura
                  child: Image.asset(
                    'assets/destaques/combo_pizza.png',
                    fit: BoxFit.cover,
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