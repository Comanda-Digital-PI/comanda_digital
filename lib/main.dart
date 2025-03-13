import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/routes/app_pages.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/utils/app_bindings.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange, // Define a cor primária do tema
        brightness: Brightness.light, // Tema claro
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black), // Estilo de texto global
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange, // Cor da AppBar
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.login,
      initialBinding: AppBindings(), 
    );
  }
}

