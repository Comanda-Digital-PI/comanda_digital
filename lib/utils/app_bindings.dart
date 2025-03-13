import 'package:flutter_faculdade/app/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController(), permanent: true); // Criamos globalmente
  }
}