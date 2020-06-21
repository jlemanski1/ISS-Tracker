import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                    
                  },
                  switchValue: false,
                ),
                SettingsTile.switchTile(
                  title: 'Toggle Theme',
                  subtitle: 'Light Mode',
                  leading: Icon(Icons.threesixty),
                  onToggle: (bool value) {

                  },
                  switchValue: false,
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

                  },
                ),
                SettingsTile(
                  title: 'Privacy Policy',
                  leading: Icon(Icons.spellcheck),
                  onTap: () {

                  },
                ),
                SettingsTile(
                  title: 'Rate App!',
                  leading: Icon(Icons.star),
                  onTap: () {
                    
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