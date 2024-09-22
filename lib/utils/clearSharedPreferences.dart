import 'package:shared_preferences/shared_preferences.dart';

//Serve para limpar a memoria em testes
Future<void> clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
