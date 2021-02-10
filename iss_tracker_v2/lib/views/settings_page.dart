import 'dart:async';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:package_info/package_info.dart';


class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Completer<WebViewController> _webController = Completer<WebViewController>();
  String appVersion, buildNum;



  @override
  void initState() {
    super.initState();

    Settings.getLightMode();

    // Get app version & build number to display on settings tile
    PackageInfo.fromPlatform().then((PackageInfo pkgInfo) {
      setState(() {
        appVersion = pkgInfo.version;
        buildNum = pkgInfo.buildNumber;
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            ClayContainer(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 75,
              depth: 50,
              customBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                    fontSize: 24,
                    color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 8.0)),
            Expanded(
              child: Container(
                color: Settings.isLightTheme ? Colors.white : Colors.black,
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: 'Units',
                      tiles: [
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
                      ],
                    ),
                    SettingsSection(
                      title: 'Theme',
                      tiles: [
                        SettingsTile.switchTile(
                          title: 'Toggle Theme',
                          subtitle: Settings.isLightTheme ? 'Light Mode' : 'Dark Mode',
                          leading: Icon(Icons.threesixty),
                          onToggle: (bool value) {
                            setState(() {
                              Settings.isLightTheme = value;
                            });
                            Settings.saveTheme();
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
                            StoreRedirect.redirect(androidAppId: 'tech.jlemanski.iss_tracker_v2');
                          },
                        ),
                        SettingsTile(
                          title: 'Version Number',
                          subtitle: '$appVersion+$buildNum',
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}