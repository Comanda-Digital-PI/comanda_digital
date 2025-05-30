import 'package:flutter_faculdade/app/controllers/config_controller.dart';
import 'package:flutter_faculdade/app/controllers/navigation_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/app/screens/configs/config_screen.dart';
import 'package:flutter_faculdade/app/screens/home/home_screen.dart';
import 'package:flutter_faculdade/app/screens/auth/login_screen.dart';
import 'package:flutter_faculdade/app/screens/home/widgets/product_widget.dart';
import 'package:flutter_faculdade/app/screens/lists/view_lists_screen.dart';
import 'package:flutter_faculdade/app/screens/mesas/mesas_screen.dart';
import 'package:flutter_faculdade/app/screens/pedidos/pedidos_screen.dart';
import 'package:flutter_faculdade/app/screens/pedidos/widgets/criar_pedido_screen.dart';
import 'package:flutter_faculdade/utils/widgets/global_scaffold.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      transition: Transition.noTransition, 
    ),
    
    GetPage(
      name: AppRoutes.globalScaffold,
      page: () => GlobalScaffold(),
      binding: BindingsBuilder(() {
        Get.put(NavigationController(), permanent: true);

      },),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.product,
      page: () {
        // pega o ConfigController que já existe
        final cfg = Get.find<ConfigController>();
        // passa direto pro seu widget
        return ProductWidget<ConfigController>(
          controller: cfg,
          title: cfg.appBarTitle.value,
        );
      },
    ),
    GetPage(
      name: AppRoutes.pedidos,
      page: () => const PedidosScreen(),
    ),
    GetPage(
      name: AppRoutes.mesas,
      page: () => const MesasScreen(),
    ),
    GetPage(
      name: AppRoutes.addConfig,
      page: () => ConfigScreen(),
    ),
    GetPage(
      name: AppRoutes.viewLists,
      page: () => ViewlistsScreen(),
    ),
    GetPage(
      name: AppRoutes.criaPedido,
      page: () => CriaPedidoScreen(),
    ),
  ];
}