import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static bool isMetric = true;
  static bool isLightTheme = true;

  static void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLightTheme') == false) {
      prefs.setBool('isLightTheme', true);
    } else {
      prefs.setBool('isLightTheme', false);
    }
  }

  static void getLightMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Settings.isLightTheme = prefs.getBool('isLightTheme');
  }
}