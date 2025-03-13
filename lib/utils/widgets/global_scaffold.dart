import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/controllers/navigation_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/app/screens/home_screen.dart';
import 'package:get/get.dart';


class GlobalScaffold extends StatelessWidget {
  // final Widget child;

  GlobalScaffold({super.key});
  final NavigationController _controller = Get.find<NavigationController>();
    final List<Widget> screens = [
      HomeScreen(),

    ];

  @override
  Widget build(BuildContext context) {
    return 
    Obx(
      () { 
        return 
          Scaffold(
            
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Get.offNamed(AppRoutes.login);
                  },
                )
              ],
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text( 
                _controller.appBarTitle.value,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              // actionsIconTheme: ,
            ),      
            body:
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200), // Tempo de animação da troca de telas
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: IndexedStack(
                key: ValueKey<int>(_controller.selectedIndex.value), // Permite a transição suave ao mudar a tela
                index: _controller.selectedIndex.value,
                children: screens, // Aqui as telas ficam carregadas
              ),
            ),
            bottomNavigationBar: 
              BottomNavigationBar(
                currentIndex: _controller.selectedIndex.value,
                onTap: _controller.changePage,
                backgroundColor: Colors.deepOrange,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                elevation: 0, // Remove sombra se necessário
                items: const [
                  
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_business_outlined),
                    activeIcon: Icon(Icons.add_business_rounded),
                    label: 'Add Product',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.format_list_bulleted_rounded),
                    activeIcon: Icon(Icons.list_rounded),
                    label: 'List Products',
                  ),
                ],
              ),


          );
      }
    );
    
  }
}
