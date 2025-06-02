import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:get/get.dart';

class Categorias extends StatelessWidget {

  final ConfigController controller = Get.find<ConfigController>();

  Categorias({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              // flex: 2,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin:  const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    controller.appBarTitle.value = 'Pratos';
                    controller.produtosFiltered.value = controller.produtos.where((i) => i.categoria == 'Pratos').toList();
                    Get.toNamed(AppRoutes.product);
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple
                        ]
                      ),
                      // borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.dinner_dining_outlined, 
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                    
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Pratos',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.deepPurpleAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin:  const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    controller.appBarTitle.value = 'Bebidas';
                    controller.produtosFiltered.value = controller.produtos.where((i) => i.categoria == 'Bebidas').toList();
                    Get.toNamed(AppRoutes.product);
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple
                        ]
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.coffee, 
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                    
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Bebidas',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.deepPurpleAccent,
                elevation: 3,
                margin:  const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    controller.appBarTitle.value = 'Aperitivos';
                    controller.produtosFiltered.value = controller.produtos.where((i) => i.categoria == 'Aperitivos').toList();
                    Get.toNamed(AppRoutes.product);
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple
                        ]
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.fastfood_outlined, 
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'Aperitivos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.deepPurpleAccent,
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin:  const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    controller.appBarTitle.value = 'Drinks';
                    controller.produtosFiltered.value = controller.produtos.where((i) => i.categoria == 'Drinks').toList();
                    Get.toNamed(AppRoutes.product);
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple
                        ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgIcon(
                            icon: SvgIconData('assets/drink_icon.svg'),
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'Drinks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.deepPurpleAccent,
                elevation: 3,
                margin:  const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    controller.appBarTitle.value = 'Sobremesas';
                    controller.produtosFiltered.value = controller.produtos.where((i) => i.categoria == 'Sobremesas').toList();
                    Get.toNamed(AppRoutes.product);
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple
                        ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.cake_rounded, 
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'Sobremesas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.deepPurpleAccent,
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin:  const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    controller.appBarTitle.value = 'Cardápio';
                    controller.produtosFiltered.value = controller.produtos.value.toList();
                    Get.toNamed(AppRoutes.product);
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.purple
                        ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add_circle_outline, 
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'Ver todos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
