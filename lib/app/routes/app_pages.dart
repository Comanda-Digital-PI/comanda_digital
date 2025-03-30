import 'package:flutter_faculdade/app/controllers/navigation_controller.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/app/screens/configs/config_screen.dart';
import 'package:flutter_faculdade/app/screens/home_screen.dart';
import 'package:flutter_faculdade/app/screens/auth/login_screen.dart';
import 'package:flutter_faculdade/app/screens/mesas_screen.dart';
import 'package:flutter_faculdade/app/screens/pedidos_screen.dart';
import 'package:flutter_faculdade/utils/widgets/global_scaffold.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
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

  ];
}