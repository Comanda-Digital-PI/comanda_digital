 
 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {

  final ConfigController controller = Get.find<ConfigController>();

  ProductWidget({
    super.key,
    
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.appBarTitle.value
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: 
      Obx(() {
        if(controller.produtosFiltered.isEmpty){
          return const Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dangerous_outlined,
                        color: Colors.deepPurple,
                        size: 70,
                      ),
                      Text(
                        'Cadastre um produto para essa categoria para visualiza-los',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      )
                    ]
                  ),
                ),
              )
            ],
          );
        } else {

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,     
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.produtosFiltered.length,
            itemBuilder: (context, index) {
              final produto = controller.produtosFiltered[index];

              return Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Foto do produto ocupando a maior parte do card
                    Expanded(
                      flex: 7,
                      child: Image.file(
                        File(produto.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Dados do produto
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              produto.nomeProduto,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "R\$ ${produto.valor.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },)
    );
  }
 }
