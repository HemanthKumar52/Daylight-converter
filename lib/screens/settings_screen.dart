import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Done", style: TextStyle(color: Color(0xFFFF9900))),
          )
        ],
      ),
      body: ListView(
        children: [
          // Theme Section
          _buildSectionHeader(context, "Theme"),
          ListTile(
            title: const Text("Appearance"),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              underline: Container(),
              onChanged: (ThemeMode? newValue) {
                if (newValue != null) {
                  settings.themeMode = newValue;
                }
              },
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text("System")),
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
              ],
            ),
          ),

          // Display Section
          _buildSectionHeader(context, "Display"),
          SwitchListTile(
            title: const Text("Show Center Line"),
            value: settings.showCenterLine,
            onChanged: (bool value) {
              settings.showCenterLine = value;
            },
            activeColor: const Color(0xFFFF9900),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Shows a vertical line at the center of timezone cards to indicate current time position",
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
