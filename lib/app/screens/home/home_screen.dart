import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/caroussel_promocoes.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/categorias_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(Object context) {
    return   Column(
      children: [
        const Categorias(),
        const SizedBox(height: 10,),
        const CarouselPromocoes(),
        const SizedBox(height: 10,),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Prontos para entrega',
                      style: TextStyle(
                        color: Colors.black,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black, 
                            width: 1
                          )
                        )
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        )
      ],
    );
  }


}





