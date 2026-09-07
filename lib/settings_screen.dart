import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Settings & Privacy", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          _buildSectionHeader("Account"),
          _buildListTile(Icons.person, "Account Information"),
          _buildListTile(Icons.security, "Security & 2FA"),
          _buildListTile(Icons.lock, "Privacy"),
          
          _buildSectionHeader("Content & Display"),
          _buildListTile(Icons.data_usage, "Data Saver"),
          _buildListTile(Icons.cleaning_services, "Free up space (Clear Cache)"),
          _buildListTile(Icons.notifications, "Notifications"),

          _buildSectionHeader("Support & About"),
          _buildListTile(Icons.help, "Help Center"),
          _buildListTile(Icons.article, "Terms & Policies"),
          _buildListTile(Icons.switch_account, "Switch Account"),
          _buildListTile(Icons.logout, "Log Out", textColor: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, {Color textColor = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor, fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
      onTap: () {},
    );
  }
}
