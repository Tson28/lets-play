import 'package:flutter/material.dart';
import 'team_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String initialName;
  final String initialLanguage;

  const SettingsScreen({
    super.key,
    required this.initialName,
    required this.initialLanguage,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _name;
  late String _language;

  @override
  void initState() {
    super.initState();
    _name = widget.initialName;
    _language = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF381024),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop({'name': _name, 'language': _language}),
        ),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _buildSettingsItem(
                context,
                Icons.language,
                'Language',
                subtitle: _language,
                hasTrailing: true,
                onTap: _showLanguageDialog,
              ),
              const Divider(color: Colors.white24),
              _buildSettingsItem(
                context,
                Icons.person_outline,
                'Edit Profile',
                subtitle: _name,
                onTap: _showEditProfileDialog,
              ),
              const Divider(color: Colors.white24),
              _buildSettingsItem(
                context,
                Icons.volume_up_outlined,
                'Sound & Haptics',
                isSwitch: true,
              ),
              const Divider(color: Colors.white24),
              _buildSettingsItem(context, Icons.help_outline, 'Help & Support'),
              const Divider(color: Colors.white24),
              _buildSettingsItem(
                context,
                Icons.groups_outlined,
                'About Team',
                onTap: (ctx) => Navigator.push(
                  ctx,
                  MaterialPageRoute(builder: (context) => const TeamScreen()),
                ),
              ),
              const Divider(color: Colors.white24),
              _buildSettingsItem(
                context,
                Icons.logout,
                'Log Out',
                isDestructive: true,
                onTap: (_) => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF381024),
          title: const Text(
            'Select Language',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Vietnamese', style: TextStyle(color: Colors.white)),
                leading: const Icon(Icons.flag, color: Colors.blue),
                trailing: _language == 'Vietnamese' ? const Icon(Icons.check, color: Colors.white) : null,
                onTap: () {
                  setState(() {
                    _language = 'Vietnamese';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('English', style: TextStyle(color: Colors.white)),
                leading: const Icon(Icons.flag, color: Colors.red),
                trailing: _language == 'English' ? const Icon(Icons.check, color: Colors.white) : null,
                onTap: () {
                  setState(() {
                    _language = 'English';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: _name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF381024),
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _name = nameController.text.trim().isEmpty ? _name : nameController.text.trim();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save', style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title, {
    String? subtitle,
    bool hasTrailing = false,
    bool isSwitch = false,
    bool isDestructive = false,
    void Function(BuildContext)? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red.withOpacity(0.2) : Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isDestructive ? Colors.redAccent : Colors.white70, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12))
          : null,
      trailing: isSwitch
          ? Switch(value: true, onChanged: (v) {}, activeColor: Colors.pinkAccent)
          : hasTrailing
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.flag, color: Colors.blue, size: 16),
                    const SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
                  ],
                )
              : Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
      onTap: () => onTap?.call(context),
    );
  }
}
