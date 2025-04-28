import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/navigation_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/app/screens/configs/config_screen.dart';
import 'package:flutter_faculdade/app/screens/home/home_screen.dart';
import 'package:flutter_faculdade/app/screens/mesas_screen.dart';
import 'package:flutter_faculdade/app/screens/pedidos_screen.dart';
import 'package:get/get.dart';

class GlobalScaffold extends StatelessWidget {
  // final Widget child;

  GlobalScaffold({super.key});
  final NavigationController _controller = Get.find<NavigationController>();
  final List<Widget> screens = [
    const HomeScreen(),
    const MesasScreen(),
    const PedidosScreen(),
    ConfigScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),

          actions: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print('aaaaaaa');
                    }
                  },
                  icon: const Icon(
                    Icons.person_2_sharp,
                    color: Colors.deepPurple,
                  )),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Get.offNamed(AppRoutes.login);
              },
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            _controller.appBarTitle.value,
            style: const TextStyle(color: Colors.white),
          ),
          // actionsIconTheme: ,
        ),
        body: AnimatedSwitcher(
          duration: const Duration(
              milliseconds: 200), // Tempo de animação da troca de telas
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: IndexedStack(
            key: ValueKey<int>(_controller.selectedIndex
                .value), // Permite a transição suave ao mudar a tela
            index: _controller.selectedIndex.value,
            children: screens, // Aqui as telas ficam carregadas
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _controller.selectedIndex.value,
          onTap: _controller.changePage,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          elevation: 0, // Remove sombra se necessário
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 25,
              ),
              activeIcon: Icon(
                Icons.home,
                size: 25,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.table_restaurant_outlined,
                size: 25,
              ),
              activeIcon: Icon(
                Icons.table_restaurant,
                size: 25,
              ),
              label: 'Mesas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart_rounded),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business_outlined),
              activeIcon: Icon(Icons.add_business),
              label: 'Config. Loja',
            ),
          ],
        ),
      );
    });
  }
}
