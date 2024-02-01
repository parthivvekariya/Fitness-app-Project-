import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> profileSettings = [
    'User Name',
    'Profile Picture',
    'Gender',
    'Date of Birth',
    'Weight',
    'Height'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Settings
            _buildSectionHeader('Profile Settings'),
            _buildSettingsList(profileSettings),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsList(List<String> settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (String setting in settings) _buildEditableSettingItem(setting),
      ],
    );
  }

  Widget _buildEditableSettingItem(String label) {
    TextEditingController controller = TextEditingController(text: label);

    return ListTile(
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Edit $label',
        ),
        onTap: () {
          // You can add specific behavior when the text field is tapped
        },
        onFieldSubmitted: (newValue) {
          // Handle the submitted value, e.g., update the list
          setState(() {
            profileSettings[profileSettings.indexOf(label)] = newValue;
          });
        },
      ),
    );
  }
}
