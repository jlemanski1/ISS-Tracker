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
              title: 'Section',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onTap: () {

                  },
                ),
                SettingsTile(
                  title: 'Units',
                  subtitle: 'Metric',
                  leading: Icon(Icons.import_export),
                  onTap: () {
                    
                  },
                ),
                SettingsTile(
                  title: 'Toggle Theme',
                  subtitle: 'Light Mode',
                  leading: Icon(Icons.calendar_today),
                  onTap: () {

                  },
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
                  leading: Icon(Icons.polymer),
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