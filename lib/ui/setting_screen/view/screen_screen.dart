import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routers/screens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isNotificationEnabled = true;
  String selectedLanguage = 'Japaneses'; // Japanese

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 20),
        ), // "Settings" in Japanese
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Change Language'), // Change Language
            subtitle: Text(selectedLanguage),
            onTap: () {
              _showLanguageDialog();
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'), // Dark Mode
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Enable Notifications'), // Enable Notifications
            value: isNotificationEnabled,
            onChanged: (value) {
              setState(() {
                isNotificationEnabled = value;
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'), // Logout
            onTap: () {
              _confirmLogout();
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'), // Select Language
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Tiếng Nhật'),
              value: 'Tiếng Nhật',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Tiếng Anh'),
              value: 'Tiếng Anh',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm logout？'), // Confirm logout
        actions: [
          TextButton(
            child: const Text('Cancel'), // Cancel
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Logout'), // Logout
            onPressed: () {
              Get.offAllNamed(Home.home);
            },
          ),
        ],
      ),
    );
  }
}
