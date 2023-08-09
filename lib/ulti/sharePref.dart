import 'package:shared_preferences/shared_preferences.dart';

saveLanguage(String lang) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("lang", lang);
}

Future<String> getLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("lang")?? "en";
}
