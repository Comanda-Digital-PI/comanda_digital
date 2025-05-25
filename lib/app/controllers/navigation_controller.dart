import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = 0.obs;
  final RxString appBarTitle = 'Home'.obs;

  void changePage(int index) {
    selectedIndex.value = index;

    switch (selectedIndex.value) {
      case 0:
        appBarTitle.value = 'Home';
        return;
      case 1:
        appBarTitle.value = 'Mesas';
        return;
      case 2:
        appBarTitle.value = 'Pedidos';
        return;
      case 3:
        appBarTitle.value = 'Adicionar';
        return;
    }
  }
  
}