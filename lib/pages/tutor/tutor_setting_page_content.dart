import 'package:flutter/material.dart';
import 'package:tutornest/pages/tutor/edit_profile_page.dart';
import 'package:tutornest/pages/tutor/tutor_lesson_report_page.dart';
import '../../services/settings_service.dart';
import '../../widgets/profile_card.dart';
import '../../models/user_profile.dart';
import 'tutor_profile_card.dart';

class TutorSettingsPageContent extends StatefulWidget {
  @override
  _TutorSettingsPageContentState createState() => _TutorSettingsPageContentState();
}

class _TutorSettingsPageContentState extends State<TutorSettingsPageContent> {
  final SettingsService _settingsService = SettingsService(); // Instantiate the service

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
                    "This application is designed to help tutors manage their lessons, track student progress, and access various tools to enhance teaching effectiveness. This content is a placeholder for the About section.",
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
          // No AppBar here; handled by TutorMainPage
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
    // Removed Scaffold, as this will be handled by TutorMainPage
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use FutureBuilder to fetch user profile data
          FutureBuilder<UserProfile>(
            future: _settingsService.fetchUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading indicator while data is loading
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Show error message if something went wrong
                return Center(child: Text("Failed to load user profile."));
              } else if (snapshot.hasData) {
                // Display the ProfileCard
                return TutorProfileCard();
              } else {
                // If data is null
                return Center(child: Text("No user data available."));
              }
            },
          ),
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
          // Lesson Report
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text("Lesson Report"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to LessonReportPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TutorLessonReportPage()),
              );

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
