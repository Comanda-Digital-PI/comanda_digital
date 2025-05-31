import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/product_widget.dart';
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
                    controller.showProduct('Pratos');
                    Get.to(() => ProductWidget<ConfigController>(
                      controller: controller,
                      title: 'Pratos',
                    ));
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
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
                    controller.showProduct('Bebidas');
                    Get.to(() => ProductWidget<ConfigController>(
                      controller: controller,
                      title: 'Bebidas',
                    ));
                  },
                  child: Ink(
                    decoration:  const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
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
                    controller.showProduct('Aperitivos');
                    Get.to(() => ProductWidget<ConfigController>(
                      controller: controller,
                      title: 'Aperitivos',
                    ));
                  },
                  child: Ink(
                    decoration:  const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
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
                    controller.showProduct('Drinks');
                    Get.to(() => ProductWidget<ConfigController>(
                      controller: controller,
                      title: 'Drinks',
                    ));
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
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
                    controller.showProduct('Sobremesas');
                    Get.to(() => ProductWidget<ConfigController>(
                      controller: controller,
                      title: 'Sobremesas',
                    ));
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
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
                    controller.showProduct('Cardapio');
                    Get.to(() => ProductWidget<ConfigController>(
                      controller: controller,
                      title: 'Cardapio',
                    ));
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
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
