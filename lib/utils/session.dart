import 'package:shared_preferences/shared_preferences.dart';

/// Salva uma preferência com o nome e valor fornecidos.
Future<void> setSession(String name, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(name, value);
}

/// Busca uma preferência pelo nome fornecido.
Future<String?> getSession(String name) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(name);
}

// Remover um preferência pelo nome forneceido
Future<bool> removeSession(String name) async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.remove(name);
}