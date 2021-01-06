//Extensions
import 'package:shared_preferences/shared_preferences.dart';

//Funciones utilizadas para guardar y recuperar variables almacenadas en la memoria del dispositivo
//Cada función se limita a un tipo de dato, se debe tener en cuenta que la respuesta es un "Future"
//Se recomienda usar una sentencia then catch para la recepción de la información

Future<void> setPrefsString(String name, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(name, value);
}

Future<String> getPrefsString(String name) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(name) ?? '';
}

Future<void> setPrefsInt(String name, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(name, value);
}

Future<int> getPrefsInt(String name) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(name) ?? 0;
}

Future<void> setPrefsBool(String name, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(name, value);
}

Future<bool> getPrefsBool(String name) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(name) ?? false;
}
