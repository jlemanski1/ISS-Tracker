import 'dart:async';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:store_redirect/store_redirect.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Completer<WebViewController> _webController = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
        title: Text("Settings",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Container(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'General',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onTap: () {

                  },
                ),
                SettingsTile.switchTile(
                  title: 'Units',
                  subtitle: 'Metric',
                  leading: Icon(Icons.import_export),
                  onToggle: (bool value) {
                    setState(() {
                      Settings.isMetric = value;            
                    });
                  },
                  switchValue: Settings.isMetric,
                ),
                SettingsTile.switchTile(
                  title: 'Toggle Theme',
                  subtitle: 'Light Mode',
                  leading: Icon(Icons.threesixty),
                  onToggle: (bool value) {
                    setState(() {
                      Settings.isLightTheme = value;
                    });
                  },
                  switchValue: Settings.isLightTheme,
                )
              ],
            ),
            SettingsSection(
              title: 'Misc',
              tiles: [
                SettingsTile(
                  title: 'Terms of Service',
                  leading: Icon(Icons.description),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WebView(
                        initialUrl: 'https://iss-tracker.flycricket.io/terms.html',
                        onWebViewCreated: (WebViewController webViewController) {
                          _webController.complete(webViewController);
                        },
                      )
                    ));
                  },
                ),
                SettingsTile(
                  title: 'Privacy Policy',
                  leading: Icon(Icons.spellcheck),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WebView(
                        initialUrl: 'https://iss-tracker.flycricket.io/privacy.html',
                        onWebViewCreated: (WebViewController webViewController) {
                          _webController.complete(webViewController);
                        },
                      )
                    ));
                  },
                ),
                SettingsTile(
                  title: 'Rate App!',
                  leading: Icon(Icons.star),
                  onTap: () {
                    StoreRedirect.redirect(androidAppId: 'tech.jlemanski.iss_tracker');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}