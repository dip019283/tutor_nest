import 'package:flutter/material.dart';
import 'package:tutornest/pages/Admin/admin_profile_card.dart';
import 'package:tutornest/pages/Admin/edit_profile_page.dart';
import '../../services/settings_service.dart';
import '../../widgets/profile_card.dart';
import '../../models/user_profile.dart';


class AdminSettingsPage extends StatefulWidget {
  @override
  _AdminSettingsPageState createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final SettingsService _settingsService = SettingsService();

  bool isDarkMode = false;
  String selectedLanguage = "English";

  final List<Map<String, String>> languages = [
    {"name": "English", "image": "assets/us_flag.png"},
    {"name": "Nepali", "image": "assets/np_flag.png"},
    {"name": "Spanish", "image": "assets/sp_flag.png"},
  ];

  // Function to show Terms/Privacy dialog
  void showTermsPrivacyDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          // Cover 80% of the screen height
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle "Don't Accept" action
                      Navigator.pop(context);
                      // You can add additional logic here if needed
                    },
                    child: const Text("Don't Accept"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Accept" action
                      Navigator.pop(context);
                      // You can add additional logic here if needed
                    },
                    child: const Text("Accept"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the About dialog
  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5, // 50% height for About dialog
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "About",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "This application is designed to help administrators manage user accounts, oversee platform settings, and ensure smooth operation of the application. This content is a placeholder for the About section.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to navigate to another page
  void navigateToNextPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          // No AppBar here; handled by AdminMainPage
          body: SafeArea(
            child: Center(
              child: Text(
                "Welcome to the $title page!",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Removed Scaffold, as this will be handled by AdminMainPage
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminCard(),
          const SizedBox(height: 24),

          // App Settings Section
          const Text(
            "App Settings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Dark Mode Toggle
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark mode"),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                  // Optionally, update the app's theme here
                });
              },
            ),
          ),
          // Language Selection
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang["name"],
                  child: Row(
                    children: [
                      Image.asset(lang["image"]!, width: 24, height: 24),
                      const SizedBox(width: 8),
                      Text(lang["name"]!),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                  // Optionally, handle language change here
                });
              },
            ),
          ),
          const SizedBox(height: 24),

          // Account Section
          const Text(
            "Account",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Create Notification ListTile
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Create Notification"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to NotificationCreatorPage
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationCreatorPage()),
              // );
            },

          ),
          // Privacy Policy
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => showTermsPrivacyDialog(
              context,
              "Privacy Policy",
              "This is the Privacy Policy content. Here you can explain how user data is handled. This is placeholder text for demonstration purposes.",
            ),
          ),
          // Terms and Conditions
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("Terms and Conditions"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => showTermsPrivacyDialog(
              context,
              "Terms and Conditions",
              "These are the Terms and Conditions. Users must agree to these terms to use the app. This is placeholder text for demonstration purposes.",
            ),
          ),
          // About
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => showAboutDialog(context),
          ),
        ],
      ),
    );
  }
}



