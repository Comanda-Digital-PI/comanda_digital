import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
              padding: EdgeInsets.all(5.0),
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
                child: const Center(child: Text('Teste 1')),
              ),
              Card(
                elevation: 3,
                color: Colors.grey.shade300,
                child: const Center(child: Text('Teste 2')),
              ),
              Card(
                elevation: 3,
                color: Colors.grey.shade300,
            
                child: const Center(child: Text('Teste 3')),
              ),
            ],
          ),
        ),
    
      ],
    );
  }
}