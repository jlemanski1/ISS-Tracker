import 'dart:io';

import 'package:yaml/yaml.dart';


class Settings {
  static bool isMetric = true;
  static bool isLightTheme = true;

  // Reads the pubspec yaml file and returns the app version for display in app
  static String getAppVersion () {
    String vers;
    File pubspec = new File('../../pubspec.yaml');
    pubspec.readAsString().then((String text) {
      Map yaml = loadYaml(text);
      vers = yaml['version'];
    });
    return vers;
  }

}