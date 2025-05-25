import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faculdade/app/routes/app_pages.dart';
import 'package:flutter_faculdade/app/routes/app_routes.dart';
import 'package:flutter_faculdade/utils/app_bindings.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comanda Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        brightness: Brightness.light, // Tema claro
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 18, color: Colors.black), // Estilo de texto global
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // Cor da AppBar
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.login,
      initialBinding: AppBindings(),
    );
  }
}
